/****************************************************************************/
/*  Archivo:            rem_parctocble.sp                                   */
/*  Stored procedure:   sp_rem_parctocble                                   */
/*  Base de datos:      cob_remesas                                         */
/*  Producto:           Personalizacion                                     */
/****************************************************************************/
/*                                 IMPORTANTE                               */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                               PROPOSITO                                  */
/*                                                                          */
/****************************************************************************/
/*                          MODIFICACIONES                                  */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_rem_parctocble')
  drop proc sp_rem_parctocble
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_rem_parctocble (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		   int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		   char(1) = 'N',
	@t_file			varchar(14) = NULL,
	@t_from			varchar(32) = NULL,
	@t_trn			smallint =NULL,
   @i_oper			char(3) ,
   @i_cons_profinal	char(1) = 'N',
   @i_cons_cta		   char(1) = 'N',
	@i_profinal		   smallint = NULL,
   @i_categoria 		char(3) = NULL,
   @i_posteo	     	char(1) = 'N',
	@i_pro_bancario	smallint = NULL,
   @i_tipo_ente		char(1) = NULL,
	@i_producto		   tinyint = NULL,
	@i_moneda		   tinyint = NULL,
	@i_filial		   tinyint = NULL,
	@i_oficina		   smallint = NULL,
	@i_cuenta		   char(16) = NULL,
	@i_tipo_cta		   char(3) = NULL, 
   @i_tipo           char(1) = NULL,
   @i_numtot         smallint = NULL, 
   @i_numcre         smallint = NULL, 
   @i_numdeb         smallint = NULL, 
   @i_numco          smallint = NULL, 
   @i_fechavig       datetime = NULL,
	@i_formato_fecha 	tinyint = 101, 
   @i_tipo_tran      smallint= null,
   @i_tipo_imp       char(1)= null,
   @i_base1          varchar(30) = null,
   @i_base2          varchar(30) = null, 
   @i_prod           tinyint     = null,
   @i_causa_org      varchar(5)  = null, 
   @i_causa_dst      varchar(5)  = null, 
   @i_indicador      tinyint     = null,
   @i_concepto       varchar(16) = null,
   @i_contabiliza    varchar(30) = null,
   @i_descripcion    varchar(64) = null,
   @i_sec            int         = null,
   @i_credeb         char(1)     = null,
   @i_estado         char(1)     = null,
   @i_prodban        tinyint     = null,
   @i_clase          char(1)     = null,
   @i_totaliza       char(1)     = null
)
as
declare 
	@w_sp_name		   varchar(32),
	@w_return     	   int,
	@w_profinal		   smallint,
   @w_posteo		   char(1),
	@w_pro_bancario	smallint,
	@w_tipo_ente		char(1),
	@w_producto		   tinyint,
	@w_moneda		   tinyint,
	@w_oficina		   smallint,
	@w_sucursal		   smallint,
	@w_filial		   tinyint,
	@w_filas_return   int, --MVE Mexicanizacion, 
	@w_secuencial     int,
    @w_trngmf        int,
    @w_tipo          char(1)

-- Captura del nombre del stored procedure 
select @w_sp_name = 'sp_rem_parctocble'

-- Validar el codigo de transaccion 
if @i_oper = 'I' 
 if @t_trn <>  708 
 begin
 	exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           --  'No corresponde codigo de transaccion' 
        return 1
 end
 
if @i_oper = 'D' 
 if @t_trn <>  709 
 begin
 	exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           --  'No corresponde codigo de transaccion' 
        return 1
 end
 
if @i_oper = 'U' 
 if @t_trn <>  710
 begin
 	exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           --  'No corresponde codigo de transaccion' 
        return 1
 end
 
if @i_oper = 'S' or  @i_oper = 'C' or @i_oper = 'T' or @i_oper = 'P'
 if @t_trn <>  719
 begin
 	exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           --  'No corresponde codigo de transaccion' 
        return 1
 end



     -- ** Insert ** 
     if @i_oper = 'I'
     begin
          -- Verificacion de existencia 
          if exists (select * from cob_remesas..re_concepto_contable
                          where cc_producto = @i_prod
                            and cc_tipo_tran = @i_tipo_tran
                            and cc_causa  = @i_causa_org
                            and cc_concepto = @i_concepto
                            and cc_indicador = @i_indicador
                             )
           begin
            exec cobis..sp_cerror
	            @t_debug	= @t_debug,
		          @t_file	= @t_file,
	            @t_from	= @w_sp_name,
		          @i_num	= 720702
	            --Ya existe registro de cobro de comision
	           return 720702
           end

          select @w_secuencial=max(cc_secuencial)+1 from cob_remesas..re_concepto_contable

          /* CODIGO DE TRANSACCION PARA GENERACION DE GMF */
          select @w_trngmf = pa_int
          from  cobis..cl_parametro
          where pa_producto = 'AHO'
          and   pa_nemonico = 'TGMFBA'

         if @@rowcount = 0 begin
            exec cobis..sp_cerror
 	             @t_debug	= @t_debug,
		         @t_file	= @t_file,
	             @t_from	= @w_sp_name,
		         @i_num	= 251110	            
	           return 251110
         end

         select @w_tipo = 'M'

         if @w_trngmf = @i_tipo_tran
            select @w_tipo = 'S'

          
          begin tran

          -- Insercion de concepto contable 
          insert into cob_remesas..re_concepto_contable
                      (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa ,    cc_tipo_imp,
                       cc_credeb, cc_concepto ,     cc_indicador ,cc_campo1  ,
                       cc_campo2 ,cc_campo3,  cc_totaliza ,cc_fecha,    cc_estado, cc_tipo )
               values (@w_secuencial, @i_prod, @i_tipo_tran,@i_causa_org, @i_tipo_imp
                      , @i_credeb, rtrim(ltrim(@i_concepto)), @i_indicador, @i_contabiliza, 
                      @i_base1,@i_base2, @i_totaliza, @s_date, 'V', @w_tipo)

          if @@error <> 0
          begin
               exec cobis..sp_cerror
	            @t_debug	= @t_debug,
		    @t_file	= @t_file,
	            @t_from	= @w_sp_name,
		    @i_num	= 353520
	       -- Error al insertar cobro de comision
	       return 353520
          end

          insert into cob_remesas..re_tran_servicio (
          ts_secuencial,  ts_terminal,  ts_tipo_transaccion, 
          ts_tsfecha,     ts_char1,  ts_login, 
          ts_oficina,     ts_datetime1)
          values ( 
          @s_ssn,         @s_term,      @t_trn, 
          getdate(),      @i_oper, @s_user, 
          @s_ofi,         getdate()) 
                                                                                                                                                                                                                               
    if @@error <> 0
    begin
       -- Error en creacion de registro en transaccion de servicio 

       exec cobis..sp_cerror
       @t_debug   = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num     = 353515
       return 353515
      end                                                                                                                                                                                                                                  

    
      commit tran
      return 0
     end


     -- ** Delete ** 
     if @i_oper = 'D'
     begin
          begin tran

         delete cob_remesas..re_concepto_contable
           where cc_secuencial  = @i_sec

          if @@error <> 0
          begin
	      exec cobis..sp_cerror
	      @t_debug	= @t_debug,
     		@t_fil	= @t_file,
		   @t_from	= @w_sp_name,
		   @i_num	= 357510
	      --'Error al eliminar cobro de comision'
	      return 357510
          end
          
    insert into cob_remesas..re_tran_servicio (
    ts_secuencial,  ts_terminal,  ts_tipo_transaccion, 
    ts_tsfecha,     ts_char1,  ts_login, 
    ts_oficina,     ts_datetime1)
    values ( 
    @s_ssn,         @s_term,      @t_trn, 
    getdate(),      @i_oper, @s_user, 
    @s_ofi,         getdate()) 
                                                                                                                                                                                                                               
    if @@error <> 0
    begin
                                                                                                                                                                                                                                                     
       -- Error en creacion de registro en transaccion de servicio 
       exec cobis..sp_cerror
       @t_debug   = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num     = 353515
       return 353515
     end                                                                                                                                                                                                                                     

     commit tran
     return 0
     end


     -- ** Update ** 
     if @i_oper = 'U'
     begin
          -- Capturar el registro anterior 

        
          begin tran

          -- Actualizacion del registro, para una categoria y un producto 
          -- final dado 
          -- Actualiza en la tabla de transacciones a contabilizar 
                                                                                                                                                                                             
      update cob_remesas..re_concepto_contable set
      cc_tipo_tran         = @i_tipo_tran,
      cc_causa             = @i_causa_org,
      cc_indicador         = @i_indicador,                                                                                                                                                                                                                       
      cc_credeb            = @i_credeb,                                                                                                                                                                                                                       
      cc_campo1            = @i_contabiliza, 
      cc_campo2            = @i_base1, 
      cc_campo3            = @i_base2, 
      cc_fecha             = @s_date,
      cc_totaliza          = @i_totaliza, 
      cc_concepto          = @i_concepto,
      cc_tipo_imp          = @i_tipo_imp
      where cc_secuencial  = @i_sec
                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                              
      if @@rowcount <> 1 or @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 355014
         return 355014
                                                                                                                                                                                                                                        
      end 

    insert into cob_remesas..re_tran_servicio (
    ts_secuencial,  ts_terminal,  ts_tipo_transaccion, 
    ts_tsfecha,     ts_char1,  ts_login, 
    ts_oficina,     ts_datetime1)
    values ( 
    @s_ssn,         @s_term,      @t_trn, 
    getdate(),      @i_oper, @s_user, 
    @s_ofi,         getdate()) 
                                                                                                                                                                                                                               
                                                                                                                                                                                                                                              
    if @@error <> 0
    begin
                                                                                                                                                                                                                                                     
       -- Error en creacion de registro en transaccion de servicio 
       exec cobis..sp_cerror
       @t_debug   = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num     = 353515
       return 353515
      end                                                                                                                                                                                                                                   

          commit tran
          return 0
     end
 
--
-- Consulta de Transacciones a Contabilizar 
                                                                                                                                                                                                                
if @i_oper = 'P'
   begin
                                                                                                                                                                                                                                                      
      set rowcount 20
                                                                                                                                                                                                                                                              
      select 'TRAN'         = cc_tipo_tran,
         --    'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = cc_credeb,
             'CAUSA ORIG'   = substring(cc_causa,1,3),
          --   'CAUSA DEST'   = tc_causa_dst,
             'INDICADOR'    = cc_indicador,
             'CAMPO A CONT' = substring(cc_campo1,1,17),
             'ESTADO'       = cc_estado,
        --     'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),cc_fecha,@i_formato_fecha),
             --'INDICE'       = cc_indice,
             'REF INT'      = cc_secuencial,
	  --   'PROD BANC'    = tc_prod_banc,
	--     'CLASE'        = tc_clase,
   	     'TOTALIZA'     = cc_totaliza,
	        'CAMPO A CONT2' = substring(cc_campo2,1,17),
          'CAMPO A CONT3' = substring(cc_campo3,1,17),
          'CONCEPTO' = cc_concepto, 
          'TIP IMP' = cc_tipo_imp
        from cob_remesas..re_concepto_contable
       where cc_producto = @i_prod
         and cc_tipo_tran >@i_tipo_tran
         and (cc_causa >= @i_causa_org or cc_causa is null)
          or (cc_tipo_tran = @i_tipo_tran and cc_secuencial > @i_sec)
       order by cc_tipo_tran, cc_secuencial, cc_causa                                                                                                                                                                                                     
                                                                                                                                                                                                                                                              
      set rowcount 0
                                                                                                                                                                                                                                          
   end
                                                                                                                                                                                                                                                        

                                                                                                                                                                                                                                                              
if @i_oper = 'T'
                                                                                                                                                                                                                                         

   begin
                                                                                                                                                                                                                                                      
      set rowcount 20
                                                                                                                                                                                                                                         
      select 'TRAN'         = cc_tipo_tran,
       --      'DESCRIPCION'  = substring(cc_descripcion,1,50),
             'SIGNO'        = cc_credeb,
             'CAUSA ORIG'   = substring(cc_causa,1,3),
             --'CAUSA DEST'   = cc_causa_dst,
             'INDICADOR'    = cc_indicador,
             'CAMPO A CONT' = substring(cc_campo1,1,17),
             'ESTADO'       = cc_estado,
             --'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),cc_fecha,@i_formato_fecha),
             --'INDICE'       = cc_indice,
             'REF INT'      = cc_secuencial,
	     --'PROD BANC'    = cc_prod_banc,
	 --    'CLASE'        = tc_clase,
	     'TOTALIZA'     = cc_totaliza, 
	     'CAMPO A CONT2' = substring(cc_campo2,1,17),
       'CAMPO A CONT3' = substring(cc_campo3,1,17),
       'CONCEPTO' = cc_concepto, 
         'TIP IMP' = cc_tipo_imp
        from cob_remesas..re_concepto_contable
       where cc_producto = @i_prod
         and (cc_causa >= @i_causa_org or cc_causa is null)
         and cc_tipo_tran = @i_tipo_tran
         and cc_secuencial > @i_sec
       order by cc_secuencial
                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                            
      set rowcount 0
                                                                                                                                                                                                                                          
   end

                                                                                                                                                                                                                                                              
-- Ayuda para Consultas 
                                                                                                                                                                                                                                    
/*if @i_operacion = 'H' 
                                                                                                                                                                                                                                        
   begin
                                                                                                                                                                                                                                                      
     select tn_descripcion
       from cobis..cl_ttransaccion
      where tn_trn_code = @i_codigo
                                                                                                                                                                                                                           
     if @@rowcount = 0
       begin*/
        -- No existe cheque de camara 
       /* exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 101001
        return 1
                                                                                                                                                                                                                                              
      end
                                                                                                                                                                                                                                                     
   end
                                                                                                                                                                                                                                                        
*/
                                                                                                                                                                                                                                                              
if @i_oper = 'C'
                                                                                                                                                                                                                                         
   begin
                                                                                                                                                                                                                                                      
      set rowcount 20
                                                                                                                                                                                                                                                             
	  -- Julio 4 2002 Adriana Rodriguez   Validacion de cuasal numerica o alfabetica
                                                                                                                                                                             
 --     if @t_trn = 50 or @t_trn = 264
                                                                                                                                                                                                                          
      select 'TRAN'         = cc_tipo_tran,
             --'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = cc_credeb,
             'CAUSA ORIG'   = substring(cc_causa,1,3),
             --'CAUSA DEST'   = cc_causa_dst,
             'INDICADOR'    = cc_indicador,
             'CAMPO A CONT' = substring(cc_campo1,1,17),
             'ESTADO'       = cc_estado,
             --'PERFIL'       = cc_perfil,
             'FECHA'        = convert(varchar(10),cc_fecha,@i_formato_fecha),
             --'INDICE'       = tc_indice,
             'REF INT'      = cc_secuencial,
	     --'PROD BANC'    = tc_prod_banc,
	     --'CLASE'        = tc_clase,
	     'TOTALIZA'     = cc_totaliza, 
	     'CAMPO A CONT2' = substring(cc_campo2,1,17),
       'CAMPO A CONT3' = substring(cc_campo3,1,17),
       'CONCEPTO' = cc_concepto, 
       'TIP IMP' = cc_tipo_imp
        from cob_remesas..re_concepto_contable
       where cc_producto = @i_prod
         and convert(int, cc_causa) = convert(int,@i_causa_org)+500
         and cc_tipo_tran = @i_tipo_tran
         and cc_secuencial > @i_sec
       order by cc_tipo_tran, cc_secuencial, cc_causa                                                                                                                                                                                                     
   /*  else
                                                                                                                                                                                                                                                     
      select 'TRAN'         = tc_tipo_tran,
             'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = tc_credeb,
             'CAUSA ORIG'   = substring(tc_causa_org,1,3),
             'CAUSA DEST'   = tc_causa_dst,
             'INDICADOR'    = tc_indicador,
             'CAMPO A CONT' = substring(tc_contabiliza,1,17),
             'ESTADO'       = tc_estado,
             'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),tc_fecha,@i_formato_fecha),
             'INDICE'       = tc_indice,
             'REF INT'      = tc_secuencial,
	     'PROD BANC'    = tc_prod_banc,
	     'CLASE'        = tc_clase,
	     'TOTALIZA'     = tc_totaliza
        from cob_remesas..re_tran_contable
       where tc_producto = @i_prod
         and tc_causa_org = @i_causa
         and tc_tipo_tran = @i_codtrn
         and tc_secuencial > @i_orden
       order by tc_tipo_tran, tc_secuencial, tc_causa_org
                                                                                                                                                                                                     
                                                                                                                                                                                                                                                             
     */ set rowcount 0
                                                                                                                                                                                                                                        
   end
                                                                                                                                                                                                                                                        



/**/
     
     -- Search 
     if @i_oper = 'S'
     begin
          select pc_profinal, pc_categoria, pc_tipo, pc_numtot, pc_numcre, pc_numdeb, 
                 pc_numco, convert(char(10),pc_fechavig,@i_formato_fecha),
                 pc_estado 
          from pe_par_comision
          where pc_profinal = @i_profinal
          and (pc_categoria = @i_categoria or @i_categoria is null)
          
          if @@rowcount = 0
          begin
               exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 351573
               --'No existe registro de cobro de comision'
               return 351573
          end
          return 0
     end

return 0


GO


