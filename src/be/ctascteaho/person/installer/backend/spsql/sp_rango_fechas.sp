/****************************************************************************/
/*     Archivo:          rangofechas.sp                                       */
/*     Stored procedure: sp_rango_fechas                                  */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Personalizacion                                    */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 18-Jul-2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa consulta los rangos de edades para agregar             */
/*     características adicionales al producto bancario                     */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*    FECHA          AUTOR          RAZON                                   */
/*    18/Jul/2016   Karen Meza     Emision Inicial                          */
/****************************************************************************/

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rango_fechas')
        drop proc sp_rango_fechas
go
create proc  sp_rango_fechas 
(      
     @s_ssn           int,
     @s_srv           varchar(30)=null,
     @s_lsrv          varchar(30)=null,
     @s_user          varchar(30)=null,
     @s_sesn          int,
     @s_term          varchar(10),
     @s_date          datetime,
     @s_org           char (1),
     @s_ofi           smallint,
     @s_rol           smallint =1,
     @s_org_err       char(1)=null,
     @s_error         int = null,
     @s_sev           tinyint = null,
     @s_msg           mensaje = null,
     @t_debug         char(1)='n',
     @t_file          varchar(14)=null,
     @t_from          varchar(32)=null,
     @t_rty           char(1)='N',
     @t_trn           smallint,
     @t_show_version  bit = 0,
     @i_codigo        int =   null,
     @i_help          char(1) = null,
     @i_descripcion   varchar(60) = null,
     @i_estado        char(1) = null,
     @i_rango_ini     int = null,
     @i_rango_fin     int = null,
     @i_modo          int = null
)
as
declare @w_sp_name    varchar(30),
        @w_indice     int,
        @w_return     int
        
select @w_sp_name = 'sp_rango_fechas'

if @t_show_version = 1
  begin
    print 'stored procedure= ' + @w_sp_name + ' version= ' + '4.0.0.0'
    return 0
  end
  
if @t_trn != 732
    begin
      /* error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end  

 if @i_help  = 'S'
 begin
    if @i_modo = 0
    begin
    set rowcount 20
    select '502090' = re_codigo,
           '502091' = re_descripcion,
           '502092' = re_rango_ini,
           '502093' = re_rango_fin,
           '502094' = re_estado
    from cob_remesas..pe_pro_rango_edad
    where re_rango_ini = isnull(@i_rango_ini,re_rango_ini)
    and re_rango_fin = isnull(@i_rango_fin,re_rango_fin)
    and re_estado    = isnull(@i_estado,re_estado)
    order by re_codigo
    
    set rowcount 0
    return 0
    end
    if @i_modo = 1
    begin
    set rowcount 20
    select '502090' = re_codigo,
           '502091'  = re_descripcion,
           '502092' = re_rango_ini,
           '502093' = re_rango_fin,
           '502094' = re_estado
    from cob_remesas..pe_pro_rango_edad
    where re_codigo > @i_codigo
    and re_rango_ini = isnull(@i_rango_ini,re_rango_ini)
    and re_rango_fin = isnull(@i_rango_fin,re_rango_fin)
    and re_estado    = isnull(@i_estado,re_estado)
    order by re_codigo
    
    set rowcount 0
   return 0
    end
    
 end 
    
if @i_help  = 'D'
 begin
 
   if exists (select 1 from cob_remesas..pe_pro_final 
                    where pf_cod_rango_edad = @i_codigo)
   begin
    /* error al eliminar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357585
      return 357585
   end
   
   update cob_remesas..pe_pro_rango_edad
   set re_estado = @i_estado
   where re_codigo    = @i_codigo
    if @@error != 0 
    begin
     /* error al eliminar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357584
      return 357584
    end
    
    insert into cob_remesas..pe_tran_servicio
        (ts_secuencial,     ts_tipo_transaccion,   ts_oficina, 
         ts_usuario,        ts_terminal,           ts_fecha_cambio,   
         ts_cuenta,         ts_minimo,             ts_maximo,  
         ts_operacion,      ts_categoria,           ts_hora,
         ts_codigo)
    values 
        (@s_ssn,            @t_trn,                @s_ofi,
         @s_user,           @s_term,               @s_date,
         @i_descripcion,    @i_rango_ini,          @i_rango_fin,  
         @i_help,           @i_estado,             getdate(),
         @i_codigo)
    if @@error != 0 
    begin
     /* error al eliminar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357584
      return 357584
    end
 end
    
if @i_help  = 'U'
 begin
 
    if @i_estado = 'N'
    begin
        if exists (select 1 from cob_remesas..pe_pro_final 
                            where pf_cod_rango_edad = @i_codigo)
        begin
            /* error al eliminar pe_pro_rango_edad */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357585
            return 357585
        end
    end
    
    update cob_remesas..pe_pro_rango_edad
    set re_descripcion = @i_descripcion,
        re_rango_ini   = @i_rango_ini,
        re_rango_fin   = @i_rango_fin,
        re_estado      = @i_estado
    where re_codigo    = @i_codigo
     if @@error != 0 
    begin
     /* error al modificar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357583
      return 357583
    end
    
    insert into cob_remesas..pe_tran_servicio
        (ts_secuencial,     ts_tipo_transaccion,   ts_oficina, 
         ts_usuario,        ts_terminal,           ts_fecha_cambio,   
         ts_cuenta,         ts_minimo,             ts_maximo,  
         ts_operacion,      ts_categoria,           ts_hora,
         ts_codigo)
    values 
        (@s_ssn,            @t_trn,                @s_ofi,
         @s_user,           @s_term,               @s_date,
         @i_descripcion,    @i_rango_ini,          @i_rango_fin,  
         @i_help,           @i_estado,             getdate(),
         @i_codigo)
    if @@error != 0 
    begin
     /* error al modificar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357583
      return 357583
    end
 end 
        
if @i_help  = 'I'
 begin

    if exists (select 1 from cob_remesas..pe_pro_rango_edad 
            where re_rango_ini = @i_rango_ini
            and re_rango_fin = @i_rango_fin
            and   re_estado = 'V')
    begin
      /* existe rango edades */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357580
      return 357580
    end      

    exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_pro_rango_edad',
     @o_siguiente = @w_indice out
     
     if @w_return <> 0
     begin
      /* error al obtener secuencial pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357581
      return 357581
    end      
    
    insert into cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    values (@w_indice, @i_descripcion, @i_rango_ini, @i_rango_fin, @i_estado)    
    if @@error != 0 
    begin
     /* error al ingresar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357582
      return 357582
    end
    
    insert into cob_remesas..pe_tran_servicio
        (ts_secuencial,     ts_tipo_transaccion,   ts_oficina, 
         ts_usuario,        ts_terminal,           ts_fecha_cambio,   
         ts_cuenta,         ts_minimo,             ts_maximo,  
         ts_operacion,      ts_categoria,           ts_hora,
         ts_codigo)
    values 
        (@s_ssn,            @t_trn,                @s_ofi,
         @s_user,           @s_term,               @s_date,
         @i_descripcion,    @i_rango_ini,          @i_rango_fin,  
         @i_help,           @i_estado,             getdate(),
         @w_indice)
    if @@error != 0 
    begin
     /* error al ingresar pe_pro_rango_edad */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357582
      return 357582
    end
 
 end
    
if @i_help  = 'A'
 begin
 
  select 
         'descripcion'   =re_descripcion 
         from cob_remesas..pe_pro_rango_edad 
         where re_codigo = @i_codigo 
         and re_estado = 'V'
  
   if @@rowcount = 0
  begin
    /* no rango de edad */
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 357560
    return      357560
  end
 end
 
if @i_help  = 'V'
 begin
 select  'codigo'        = re_codigo, 
         'descripcion'   = re_descripcion ,
         'rango'         = concat(convert(varchar(5),re_rango_ini),'-',convert(varchar(5),re_rango_fin))
         from cob_remesas..pe_pro_rango_edad 
         where re_estado = 'V'
         

  if @@rowcount = 0
  begin
   /* no rango de edad */
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 357560
    return      357560
  end
 end
return
go
