/****************************************************************/
/* ARCHIVO:         cierrre_modulo.sp                           */
/* NOMBRE LOGICO:   sp_cierre_modulo                            */
/* PRODUCTO:        PLAZO FIJO                                  */
/****************************************************************/
/*                         IMPORTANTE                           */
/* Esta aplicacion es parte de los paquetes bancarios propiedad */
/* de MACOSA S.A.                                               */
/* Su uso no  autorizado queda  expresamente prohibido asi como */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus */
/* usuarios sin el debido consentimiento por escrito de MACOSA. */
/* Este programa esta protegido por la ley de derechos de autor */
/* y por las  convenciones  internacionales de  propiedad inte- */
/* lectual.  Su uso no  autorizado dara  derecho a  MACOSA para */
/* obtener  ordenes de  secuestro o retencion y  para perseguir */
/* penalmente a los autores de cualquier infraccion.            */
/****************************************************************/
/*                          PROPOSITO                           */
/* Este proceso garantiza que el modulo cierre adecaudamente    */
/* garantizadndo que no queden transacciones pendientes con     */
/* branch							*/
/****************************************************************/
/*                      MODIFICACIONES                          */
/* FECHA         AUTOR             RAZON                        */
/* 21/DIC/10     Y. Martinez       Emision Inicial              */
/****************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists(select 1 from sysobjects where name = 'sp_cierre_modulo')
   drop proc sp_cierre_modulo
go

create proc sp_cierre_modulo
(   
@s_date         datetime   = null,
@s_user         login      = null,
@s_ofi          smallint   = null,
@t_debug        char(1)    = 'N',
@t_file         varchar(14)= null,
@t_trn          smallint   = null, 
@s_ssn          int        = null,   
@s_lsrv         varchar(30)= null,   
@s_srv          varchar(30)= null,
@s_term         varchar(30)= null,
@s_rol          smallint   = null, 
@s_sesn         int        = null,
@s_org          char(1)    = null,

-----------------------------------------------------
@t_corr         char(1)     = null,
@t_ssn_corr     int         = null,
@t_from         varchar(32) = null,  
@t_rty          char(1)     = 'N',
-----------------------------------------------------
@i_operacion      varchar(1),
@i_opcion         char(2)     = null,
@i_filial         tinyint     = 1,
@i_modulo         tinyint     = 42,
@i_num_error      int         = null, 
@i_texto_error    varchar(132)= null,
@i_func_autoriza  smallint    = null,
@i_siguiente      bigint         = 0,
-----------------------------------------------------
@o_estado_suc     varchar(10) = 'X' out,
@o_estado         varchar(10) = 'X' out)
with encryption
as
declare 
@w_return               int,        
@w_sp_name              varchar(32),
@w_estado               char(1) ,   
@w_estado_suc           char(1) ,
@w_estado_cierre_of     char(1),
@w_cantd_operaciones    int,
@w_hora                 varchar(10),
@w_codigo_alterno       int,
@w_cantd_impresiones    int,
@w_error                int,
@w_rollback             char(1),
@w_funcionario          login,
@w_tipo_aut		varchar(100)

--  INCIALIZACION DE VARIABLES

SELECT  
@w_sp_name          = 'sp_cierre_modulo',
@w_estado           = null,  
@w_estado_suc       = null,
@w_codigo_alterno   = 0,
@w_rollback         = 'N',
@w_funcionario      = ''

--  OBTENER LA HORA PARA TRANSACCION DE SERVICIOS

SELECT  @w_hora = convert(varchar(10),getdate(),108)
   
--  VERIFICACION DE TIPO DE TRANSACCION

if @t_trn <> 14169 AND  @t_trn <> 14170 AND  @t_trn <> 14171
begin
   select @w_error = 2902500
   goto ERROR
end

--  INGRESAR CIERRE
IF @i_operacion = 'I'   
BEGIN   
   
   --  CONSULTAR SI EL CIERRE EXISTE SI EXISTE MARCAR ERROR
   SELECT  @w_estado =  ep_estado
   FROM    cobis..ad_estado_producto  
   WHERE   ep_modulo       = @i_modulo
   AND     ep_oficina      = @s_ofi    
   AND     ep_fecha_estado = @s_date    
   
   IF @w_estado is null BEGIN

      --  INSERTAR CIERRE
      INSERT INTO cobis..ad_estado_producto 
      (ep_filial,          ep_modulo,      ep_oficina,
       ep_fecha_estado,    ep_estado,      ep_login,
       ep_num_error,       ep_texto_error)    
      VALUES
      (@i_filial,          @i_modulo,      @s_ofi, 
       @s_date,            'A',            @s_user,
       @i_num_error,       @i_texto_error)     
        
      if (@@error <> 0)
      begin
         --> ERROR AL INGRESAR EL CIERRE DEL MODULO
         select @w_error = 2903120, @w_rollback = 'S'
         goto ERROR
      end
      
      --  REGISTRAR TRANSACCION DE SERVICIO 'A'           
      SELECT  @w_codigo_alterno = @w_codigo_alterno + 1
      insert into ts_cierre_modulo
         (secuencial,    cod_alterno,        tipo_transaccion,   clase,
          fecha,      hora,           usuario,        terminal,       
          oficina,    lsrv,           srv,            func_autoriza)
      values  (@s_ssn,    @w_codigo_alterno,  @t_trn,         'A',
          @s_date,    @w_hora,        @s_user,        @s_term,
          @s_ofi,     @s_lsrv,        @s_srv,         @i_func_autoriza)
      
      if (@@error<>0 or @@rowcount=0)
      begin
         SELECT @w_sp_name = '(A)'+@w_sp_name
         select @w_error = 2902515, @w_rollback = 'S'
         goto ERROR
      end     


      --  CONSULTAR estado BRANCH
      select @w_estado_suc = es_estado 
      from cobis..re_estado_sucursal
      where es_filial        = 1
      and   es_oficina       = @s_ofi   
      and   es_fecha_estado  = @s_date

      --  Consulta estado producto 
      SELECT  @w_estado =  ep_estado
      FROM    cobis..ad_estado_producto  
      WHERE   ep_modulo       = @i_modulo
      AND     ep_oficina      = @s_ofi    
      AND     ep_fecha_estado = @s_date    
      
      select @o_estado_suc = @w_estado_suc
      select @o_estado = @w_estado

   END 
END



IF @i_operacion = 'U'   BEGIN   

   --  LEVANTAR CIERRE

   IF @i_opcion = 'L'      BEGIN

      ---------------------------------------------------------------
      -- Verifica usuario autorizado y sus funcionarios relacionados
      ---------------------------------------------------------------

      select @w_funcionario = fu_funcionario
        from pf_funcionario
       where fu_funcionario = @s_user			-- funcionario que se logea
         and fu_tautorizacion = 'LCIERRE'
         and fu_estado = 'A'

      if @@rowcount = 0 begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,   
              @i_num   = 141134
         return 141134
      end

      --  CONSULTAR ESTADO DEL CIERRE GENERAL DE OFICINA 
      select  @w_estado_cierre_of = null
      
      SELECT  @w_estado_cierre_of = es_estado
      FROM    cobis..re_estado_sucursal
      where   es_filial       = @i_filial
      and     es_oficina      = @s_ofi    
      and     es_fecha_estado = @s_date                  
      
      --  VALIDAR QUE EL CIERRE GENERAL DE OFICINA NO SE HAYA REALIZADO
      IF  @w_estado_cierre_of = 'C' BEGIN 
         --  NO ES POSIBLE ELIMINAR EL CIERRE DEL MODULO, PORQUE YA FUE EJECUTADO EL CIERRE GENERAL DE OFICINA
         select @w_error = 2903121
         goto ERROR
      END
      ELSE BEGIN 

         UPDATE  cobis..ad_estado_producto  
         SET     ep_estado = 'A'
         WHERE   ep_modulo       = @i_modulo
         AND     ep_oficina      = @s_ofi    
         AND     ep_fecha_estado = @s_date    
         
         IF (@@error<>0 or @@rowcount=0)  BEGIN
             --ERROR AL ACTUALIZAR EL CIERRE A ESTADO APERTURA
            select @w_error = 2903122, @w_rollback = 'S'
            goto ERROR
         END 
         
         --  REGISTRAR TRANSACCION DE SERVICIO 'L'           
         SELECT  @w_codigo_alterno = @w_codigo_alterno + 1
         insert into ts_cierre_modulo
            (secuencial, cod_alterno,        tipo_transaccion,   clase,
             fecha,      hora,               usuario,            terminal,       
             oficina,    lsrv,               srv,                func_autoriza)
         values
            (@s_ssn,     @w_codigo_alterno,  @t_trn,             'L',
             @s_date,    @w_hora,            @s_user,            @s_term,
             @s_ofi,     @s_lsrv,            @s_srv,             @i_func_autoriza)

         if (@@error<>0 or @@rowcount=0) begin
            SELECT @w_sp_name = '(B)'+@w_sp_name
            select @w_error = 2902515, @w_rollback = 'S'
            goto ERROR
         end     
         
         select @o_estado = 'A'
         select @o_estado_suc = @w_estado_cierre_of

      END     
   END
            
    --  CERRAR MODULO

   IF @i_opcion = 'C' or @i_opcion = 'CF' BEGIN

IF @i_opcion = 'S' print 'i_opcion ' + cast(@i_opcion as varchar)


      if @i_opcion  <> 'N' BEGIN 

         ---------------------------------------------------------------
         -- Verifica usuario autorizado y sus funcionarios relacionados
         ---------------------------------------------------------------
         select @w_tipo_aut = ''
	 
	 if @i_opcion = 'C' 
	   select @w_tipo_aut = 'CIERRE'  -- Autorizacion Cierre normal
	 
	 if @i_opcion = 'CF' 
	   select @w_tipo_aut = 'FCIERRE'     -- Autorizacion cierre forzado

IF @w_tipo_aut = 'S' print 'i_opcion ' + cast(@w_tipo_aut as varchar)

         if @w_tipo_aut <> '' BEGIN
            select  @w_funcionario = fu_funcionario
            from    pf_funcionario
            where   fu_funcionario = @s_user			-- funcionario que se logea
            and     fu_tautorizacion = @w_tipo_aut
            and     fu_estado = 'A'

            if @@rowcount = 0 begin
               exec cobis..sp_cerror 
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,   
                    @i_num   = 141134
               return 141134
            end
         END
        
         UPDATE  cobis..ad_estado_producto  
         SET     ep_estado = 'C'
         WHERE   ep_modulo       = @i_modulo
         AND     ep_oficina      = @s_ofi    
         AND     ep_fecha_estado = @s_date    
         
             
         IF (@@error<>0 or @@rowcount=0) BEGIN
             --  ERROR AL ACTUALIZAR EL CIERRE A ESTADO CERRADO
             select @w_error = 2903124, @w_rollback = 'S'
             goto ERROR
         END 
         
         --  REGISTRAR TRANSACCION DE SERVICIO 'C' o 'N'         
         SELECT  @w_codigo_alterno = @w_codigo_alterno + 1
         insert into ts_cierre_modulo
            (secuencial,    cod_alterno,        tipo_transaccion,   clase,
             fecha,      hora,           usuario,        terminal,       
             oficina,    lsrv,           srv,            func_autoriza)
         values  (@s_ssn,    @w_codigo_alterno,  @t_trn,         @i_opcion,
             @s_date,    @w_hora,        @s_user,        @s_term,
             @s_ofi,     @s_lsrv,        @s_srv,         @i_func_autoriza)

         if (@@error<>0 or @@rowcount=0) begin
            SELECT @w_sp_name = '(C)'+@w_sp_name
            select @w_error = 2902515, @w_rollback = 'S'
            goto ERROR
         end     
        
         select @o_estado = 'C'

      END 
   END 
END

   
--  CONSULTAR ESTADO CIERRE

IF @i_operacion = 'Q'   BEGIN   


IF @t_debug = 'S' print 'i_modulo ' + cast(@i_modulo as varchar)
IF @t_debug = 'S' print 's_ofi ' + cast(@s_ofi as varchar)
IF @t_debug = 'S' print 's_date ' + cast(@s_date as varchar)
    
    SELECT @w_estado = null
   
   --  CONSULTAR estado BRANCH
   select @w_estado_suc = es_estado 
   from cobis..re_estado_sucursal
   where es_filial        = 1
   and   es_oficina       = @s_ofi   
   and   es_fecha_estado  = @s_date

    --  Consulta estado producto 
    SELECT  @w_estado =  ep_estado
    FROM    cobis..ad_estado_producto  
    WHERE   ep_modulo       = @i_modulo
    AND     ep_oficina      = @s_ofi    
    AND     ep_fecha_estado = @s_date    
    

IF @t_debug = 'S' print 'w_estado_suc ' + cast(@w_estado_suc as varchar)
IF @t_debug = 'S' print 'w_estado ' + cast(@w_estado as varchar)
    
    select @o_estado_suc = @w_estado_suc
    select @o_estado = @w_estado

IF @t_debug = 'S' print 'o_estado_suc ' + cast(@o_estado_suc as varchar)
IF @t_debug = 'S' print 'o_estado ' + cast(@o_estado as varchar)
     
END     


--  CONSULTAR OPERACIONES PENDIENTES

IF @i_operacion = 'S'   BEGIN   

   --  CONSULTAR estado BRANCH
   select @w_estado_suc = es_estado 
   from cobis..re_estado_sucursal
   where es_filial        = 1
   and   es_oficina       = @s_ofi   
   and   es_fecha_estado  = @s_date

   --  Consulta estado producto 
   SELECT  @w_estado =  ep_estado
   FROM    cobis..ad_estado_producto  
   WHERE   ep_modulo       = @i_modulo
   AND     ep_oficina      = @s_ofi    
   AND     ep_fecha_estado = @s_date    
    

    
   select @o_estado_suc = @w_estado_suc
   select @o_estado = @w_estado


   IF @t_debug = 'S' print 'i_opcion ' + cast(@i_opcion as varchar)
   IF @t_debug = 'S' print 's_date ' + cast(@s_date as varchar)
   IF @t_debug = 'S' print 's_ofi ' + cast(@s_ofi as varchar)


   IF @t_debug = 'S' print 'i_siguiente ' + cast(@i_siguiente as varchar)


   if @i_opcion  = 'T' BEGIN  -- Todas las transacciones del dia

         set rowcount 15

      select	
      'NUM.DEPOSITO'        = op_num_banco,
      'DESC.TRANSACCION'    = (select tn_descripcion from cobis..cl_ttransaccion where tn_trn_code = M.mm_tran) + ' (' + convert(varchar(20),M.mm_tran) + ')',
      'NEM. FPAGO'          = mm_producto ,
      'VALOR'               = mm_valor,
      'NUM.ID.'             = ( select en_ced_ruc from cobis..cl_ente where en_ente = isnull(M.mm_beneficiario,O.op_ente)),
      'COD ENTE'            =  isnull(mm_beneficiario,O.op_ente),
      'NOMBRE BENEFICIARIO' = ( select (case when en_subtipo = 'P' then en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido else en_nomlar end )  from cobis..cl_ente where en_ente = isnull(M.mm_beneficiario, O.op_ente)),
      'DESC. FORMA  PAGO'   = (select fp_descripcion from cob_pfijo..pf_fpago where fp_mnemonico = M.mm_producto),
      'ESTADO TRAN'         = 'APLICADO',
      'USAURIO'             = (select  (select '(' + (M.mm_usuario) + ')' + ' ' + fu_nombre) from cobis..cl_funcionario where fu_login = M.mm_usuario) ,
      'ESTADO OPERACION'    = op_estado,
      'DESMATERIALIZADO'    = op_desmaterializa,
      'MONTO'               = op_monto,
      'PLAZO '              = op_num_dias,
      'TASA Nom'            = op_tasa,
      'aux'                 = convert(varchar(20),mm_operacion)  + replicate('0', 3-datalength(convert(varchar, isnull(mm_secuencia,0)))) +  convert(varchar, isnull(mm_secuencia,0)) + replicate('0', 2-datalength(convert(varchar, isnull(mm_sub_secuencia,0)))) + convert(varchar, isnull(mm_sub_secuencia,0))
      from cob_pfijo..pf_mov_monet M,
           cob_pfijo..pf_operacion O
      where mm_operacion 	    = op_operacion
      and   mm_oficina          = @s_ofi
      and	 mm_fecha_aplicacion = @s_date
      and   mm_estado           = 'A'
      and   mm_tran             <> 14995
      and   convert(bigint,(convert(varchar(20),mm_operacion)  + replicate('0', 3-datalength(convert(varchar, isnull(mm_secuencia,0)))) +  convert(varchar, isnull(mm_secuencia,0)) + replicate('0', 2-datalength(convert(varchar, isnull(mm_sub_secuencia,0)))) + convert(varchar, isnull(mm_sub_secuencia,0)))) > convert(bigint,@i_siguiente)
      order by mm_operacion, mm_secuencia, mm_sub_secuencia
   END

   if @i_opcion  = 'P' BEGIN  -- Operaciones pendientes en EFECTIVO

         set rowcount 0

      select 
      'NUM.DEPOSITO'        = op_num_banco,
      'DESC.TRANSACCION'    = (select tn_descripcion from cobis..cl_ttransaccion where tn_trn_code = EC.ec_tran) + ' (' + convert(varchar(20),MM.mm_tran) + ')',
      'NEM. FPAGO'          = (select case when ec_fpago <> 'EFEC' then 'EFEC' else ec_fpago end ),
      'VALOR'               = ec_valor,
      'NUM.ID.'             = ( select en_ced_ruc from cobis..cl_ente where en_ente = isnull(mm_beneficiario, PF.op_ente )),
      'COD ENTE'            = isnull(mm_beneficiario,op_ente),
      'NOMBRE BENEFICIARIO' = ( select (case when en_subtipo = 'P' then en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido else en_nomlar end )  from cobis..cl_ente where en_ente = isnull(mm_beneficiario,PF.op_ente) ),
      'DESC. FORMA  PAGO'   = (select fp_descripcion from cob_pfijo..pf_fpago where fp_mnemonico = EC.ec_fpago),
      'ESTADO TRAN'         = 'PENDIENTE',
      'USAURIO'             = (select  (select (M.mm_usuario) + ' ' + fu_nombre from cobis..cl_funcionario where fu_login = M.mm_usuario) from pf_mov_monet M where mm_producto = 'EFEC' and mm_operacion = EC.ec_operacion and mm_tran = 14943 and mm_fecha_aplicacion = @s_date and mm_secuencia_emis_che = EC.ec_secuencia and mm_estado = 'A' and  mm_oficina = @s_ofi),
      'ESTADO OPERACION'    = op_estado,
      'DESMATERIALIZADO'    = op_desmaterializa,
      'MONTO'               = op_monto,
      'PLAZO '               = op_num_dias,
      'TASA Nom'                = op_tasa
      from cob_pfijo..pf_emision_cheque EC, 
           cob_pfijo..pf_operacion PF,
           cob_pfijo..pf_mov_monet MM
      where	ec_operacion 		= mm_operacion
      and   ec_operacion 		= op_operacion
      and   mm_operacion 		= op_operacion
      and   ec_secuencia 		= mm_secuencia
      and   ec_sub_secuencia 	= mm_sub_secuencia
      and   ec_tran 	   	in (14903,14904, 14943, 14905, 14543, 14168)
      and   ec_estado 	   	= 'E'
      and   ec_caja       	   	= NULL
      and   ec_fecha_caja      	= NULL
      and   ec_fecha_emision   	= @s_date
      and   ec_fpago            not in ('PCHC')
      and   exists( select  1
                        from    pf_mov_monet
                        where   mm_producto           = 'EFEC'
                        and     mm_operacion          = EC.ec_operacion
                        and     mm_tran               = 14943
                        and     mm_fecha_aplicacion   = @s_date
                        and     mm_secuencia_emis_che = EC.ec_secuencia
                        and     mm_estado             = 'A'
                        and     mm_oficina            = @s_ofi)
      union
      select	
     'NUM.DEPOSITO'        = op_num_banco,
     'DESC.TRANSACCION'    = (select tn_descripcion from cobis..cl_ttransaccion where tn_trn_code = MM.mm_tran) + ' (' + convert(varchar(20),MM.mm_tran) + ')',
     'NEM. FPAGO'          = mm_producto,
     'VALOR'               = mm_valor,
     'NUM.ID.'             = ( select en_ced_ruc from cobis..cl_ente where en_ente = isnull(mm_beneficiario, PF.op_ente )),
     'COD ENTE'            = op_ente,
     'NOMBRE BENEFICIARIO' = ( select (case when en_subtipo = 'P' then en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido else en_nomlar end )  from cobis..cl_ente where en_ente = PF.op_ente),
     'DESC. FORMA  PAGO'   = (select fp_descripcion from cob_pfijo..pf_fpago where fp_mnemonico = MM.mm_producto),
     'ESTADO TRAN'         = 'PENDIENTE',
     'USAURIO'             = (select case when mm_tran = 14904 then (select (MM.mm_usuario) + ' ' + fu_nombre from cobis..cl_funcionario where fu_login = MM.mm_usuario) else (select  (select '(' + (PF.op_oficial) + ')' + ' ' + fu_nombre) from cobis..cl_funcionario where fu_login = PF.op_oficial) end),
     'ESTADO OPERACION'    = op_estado,
     'DESMATERIALIZADO'    = op_desmaterializa,
     'MONTO'               = op_monto,
     'PLAZO '              = op_num_dias,
     'TASA.Nom'            = op_tasa
      from cob_pfijo..pf_operacion PF,
      cob_pfijo..pf_mov_monet MM
      where mm_operacion = op_operacion
      and   ((mm_tran    = 14901 and op_estado = 'ING' and op_aprobado = 'S')
      or    (mm_tran    = 14904  and mm_producto = 'EFEC' and mm_snn_rev_central = null))
      and   mm_fecha_aplicacion  = NULL
      and   mm_estado            = NULL
      and   mm_tipo              = 'B'
      and   mm_fecha_crea        = @s_date
      and   mm_oficina	         = @s_ofi
   END
END

return 0
ERROR:
    exec cobis..sp_cerror
    @t_from     = @w_sp_name,
    @i_num      = @w_error
    
    if @w_rollback = 'S'
       rollback tran
    
    return @w_error
go
