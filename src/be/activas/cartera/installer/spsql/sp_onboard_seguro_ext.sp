
/****************************************************************************/
/*  Archivo:                sp_onboard_seguro_ext.sp					    */
/*  Stored procedure:       sp_onboard_seguro_ext							*/ 
/*  Base de datos:          cob_cartera                                     */
/*  DiseÃ±ado :               AGO                                           */
/*  Producto:               Cartera			                                */
/****************************************************************************/
/*              IMPORTANTE                                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                              PROPOSITO                                   */
/*  creacion  On-Board de seguros externos                                  */
/****************************************************************************/
/*                     MODIFICACIONES                                       */
/*   FECHA          AUTOR                         RAZON                     */
/*                           Versión Inicial                                */
/*   05/09/2022     ACH      ERR#192858 alta asistencia medica              */
/****************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_onboard_seguro_ext')
   drop proc sp_onboard_seguro_ext
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO
create proc sp_onboard_seguro_ext (
	@s_srv              varchar(30)    = null,
	@s_lsrv             varchar(30)    = null,             
	@s_ssn              int            = null,
	@s_rol              int            = null,
	@s_org              char(1)        = null,
	@s_user             login          = null,
	@s_term             varchar(30)    = null,
	@s_date             datetime       = null,
	@s_sesn             int            = null,
	@s_ofi              smallint       = null,
	---------------------------------------
	@i_tramite          int,
    @i_cliente          int,
	@i_beneficiario     varchar(900),
	@i_cod_parentesco   int,
    @i_porcentaje       float,
    @i_acepto           tinyint,
    @i_otorgo           tinyint,
	@i_operacion        char(1) 
    
)
as declare 

@w_fecha_ing  datetime,
@w_sp_name    descripcion,
@w_porcentaje_monto     float,
@w_fecha_pro_orig       datetime,
@w_referencia           varchar(30),
@w_fecha_proceso        datetime,
@w_fecha_ini_credito    datetime,
@w_moneda               tinyint,
@w_oficina              smallint,
@w_ruta_xml             varchar(255),
@w_error                int,
@w_sql_bcp              varchar(5000),
@w_sql                  varchar(5000),
@w_mensaje_bcp          varchar(150),
@w_param_ISSUER         varchar(30),
@w_nombre_grupo         varchar(64),
@w_corresponsal         varchar(20), 
@w_id_corresp           varchar(10),
@w_sp_corresponsal      varchar(50),
@w_descripcion_corresp  varchar(30),
@w_fail_tran            char(1),
@w_convenio             varchar(30),
@w_tipo_tran            varchar(4),
@w_tramite              int,
@w_promocion            char(1),
@w_monto_seguro_basico  money   ,
@w_banco_grupal         cuenta  ,
@w_operacion_grupal     int     ,
@w_edad_max_param       int     ,
@w_dias_adicionales     int     ,
@w_tipo_plazo           varchar(10),
@w_plazo                int,
@w_valor_basico         money,
@w_gracia               int ,
@w_num_dec              int ,
@w_tipo_basico          catalogo,
--variables históricos
@w_secuencial           INT,
@w_cliente              int,
@w_operacion            int,
@w_banco                varchar(24),
@w_fecha_ini            datetime,
@w_monto                money,
@w_tipo_seguro          varchar(20),
@w_monto_basico         money,
@w_paga_seguro          varchar(2),
@w_resultado            varchar(2),
@w_msg                 varchar(255)     

 

select @w_sp_name = 'sp_onboard_seguro_ext'

select @w_fecha_ing  = getdate()


/*  Inicializacion de Variables  */
select 
@w_sp_name   = 'sp_data_garlig_seg',
@w_tipo_tran = 'GL',
@w_tipo_basico = 'BASICO'




select @w_dias_adicionales = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'NDEDAD'
and   pa_producto = 'ADM'


--Parametro de edad
select @w_edad_max_param=pa_tinyint 
from cobis..cl_parametro
where pa_nemonico='EMACI'
and   pa_producto='CRE'




--Fecha proceso y cálculo de fecha de vencimiento del pago
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_fecha_proceso  = convert(datetime,convert(varchar(10), @w_fecha_proceso,101) + ' ' + convert(varchar(12),getdate(),114))
select @w_fecha_pro_orig = dateadd(hour,36,@w_fecha_proceso)



if @i_operacion = 'I' begin 




  if not exists (select 1 from ca_operacion where op_tramite =@i_tramite) 
   begin
       select @w_error = 724637
       goto ERROR
   end


  if not exists (select 1 from cobis..cl_ente  where  en_ente =@i_cliente) 
   begin
       select @w_error = 724637
       goto ERROR
   end

      --Inserccion en tablas fisicas de seguro
   delete from cob_cartera..ca_onboard_seguro_ext
   where se_tramite   =  @i_tramite and se_beneficiario = @i_beneficiario


   insert into ca_onboard_seguro_ext with (rowlock) (
    se_tramite   ,se_cliente   , se_beneficiario,
	se_porcentaje,se_parentesco, se_acepto,
	se_otorgo    ,se_fecha_ing , se_usuario
   
   )
   values (
   @i_tramite    ,@i_cliente       ,@i_beneficiario ,
   @i_porcentaje ,@i_cod_parentesco,@i_acepto       , 
   @i_otorgo     ,@w_fecha_ing     ,@s_user
   )
   
   if (@@error <> 0 ) begin     
       select @w_error = 708154
       goto ERROR
   end
   
end 




---ENVIO A TABLA DE SEGUROS EXTERNOS 
if (@i_operacion = 'U') begin 

   select @w_tramite = @i_tramite

   select 
   @w_banco            = op_banco,
   @w_operacion        = op_operacion,  
   @w_tipo_plazo       = op_tplazo,
   @w_plazo            = op_plazo ,
   @w_gracia           = isnull(op_desplazamiento,0),
   @w_moneda           = op_moneda
   from   cob_cartera..ca_operacion
   where op_tramite   = @i_tramite
   
   if (@@rowcount = 0)
   begin
       select @w_error = 724637
       goto ERROR
   end
   

   --- NUMERO DE DECIMALES 
   exec @w_error = sp_decimales
   @i_moneda      = @w_moneda ,
   @o_decimales   = @w_num_dec out
   
   
   --Inserto lo que ya tengo en seguros
   create table #seguros(
    tramite     int            ,
    cliente     int         null,
    monto       money       null,
    monto_pag   money       null,
    edad_string varchar(50) null,
    anio        int         null,
    mes         int         null,
    dia         int         null,
    forma_pago  varchar(16) null,
    tipo_seguro varchar(16) null,
    monto_basico money      null)
	
	
   insert into #seguros(                            
   tramite      , cliente    ,
   monto        , monto_pag                 ,  edad_string,
   forma_pago   , tipo_seguro               , monto_basico)              
   select                                                  
   tr_tramite   , tr_cliente,
   0            , 0                         ,  null         ,
   null         , 'BASICO'                  , 0
   from cob_credito..cr_tramite 
   where tr_tramite = @i_tramite

   
   
   update #seguros set 
   edad_string=cobis.dbo.fn_calculo_edad(p_fecha_nac,dateadd(dd,@w_dias_adicionales,@w_fecha_proceso)) 
   from cobis..cl_ente
   where en_ente=cliente
   
   update #seguros set 
   anio        = convert(int,substring(edad_string,0,charindex('|',edad_string))), 
   edad_string = substring(edad_string,charindex('|',edad_string)+1,len(edad_string))
   
   update #seguros set 
   mes         = convert(int,substring(edad_string,0,charindex('|',edad_string))),
   edad_string = substring(edad_string,charindex('|',edad_string)+1,len(edad_string))
   
   update #seguros set 
   dia         = convert(int,edad_string)
   
   --Se comenta para el caso que va a pasar
   if @w_gracia >0 and @w_gracia is not null
      select @w_plazo = @w_plazo + isnull(@w_gracia,0)
      
      
      
   --INICIALIZACION POR DEFECTO    
   select  @w_paga_seguro  = 'NO' 
   
   -----------  espacio de trabajo en caso de utilizar una regla de negocio
   -----------
   
   select *
   into #ca_param_seguro_externo
   from cob_cartera..ca_param_seguro_externo
   where se_estado = 'V'
   and   se_producto = 'ONBOARD-S'
   
   
   if @w_paga_seguro = 'NO'
   begin
      update #ca_param_seguro_externo set
      se_valor = 0,
      se_asistencia_funeraria = 0
      where se_paquete = @w_tipo_basico
   end
   
   select 
   se_id, 
   se_paquete, 
   se_edad_max,  
   se_total = round(sum(se_asistencia_funeraria + se_valor) *
              case when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'D' then round(convert(float,@w_plazo)/30,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'W' then round(convert(float,@w_plazo)/ 4,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'Q' then round(convert(float,@w_plazo)/ 2,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'M' then round(convert(float,@w_plazo),0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'B' then round(convert(float,@w_plazo) * 2,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'T' then round(convert(float,@w_plazo) * 3,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'S' then round(convert(float,@w_plazo) * 6,0)
               else  
                    1
               end,@w_num_dec) ,
   se_basico    = convert(money,0)           
   into #valores_seguro
   from #ca_param_seguro_externo
   where se_estado = 'V'
   group by se_id, se_paquete, se_edad_max
   
   select @w_valor_basico =se_total
   from #valores_seguro
   where se_paquete = @w_tipo_basico
   
   update #valores_seguro set 
   se_basico   =  isnull(@w_valor_basico,0)
   where se_total > 0
   
   update #valores_seguro
   set se_total = se_total + isnull(@w_valor_basico,0)
   where se_paquete <> @w_tipo_basico
   and   se_total   > 0 
   
   update #seguros set 
   monto =se_total,
   monto_basico = se_basico
   from #valores_seguro
   where se_paquete = tipo_seguro
   and ((anio >= 18 and  anio < se_edad_max)
   or   (anio = se_edad_max and  mes = 0 and   dia = 0 ))

   --caso#192858
   update #seguros set 
   tipo_seguro = 'NINGUNO'
   from #valores_seguro
   where se_paquete = tipo_seguro
   and ((anio < 18) or  (anio > se_edad_max) or (anio = se_edad_max and mes > 0) or (anio = se_edad_max and dia > 0))
   
   update #seguros set
   monto = 0
   where tramite = @w_tramite
   and   cliente not in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite and tg_participa_ciclo = 'S' )
      
   update #seguros set
   monto_basico = 0
   where monto = 0
   
   --Inicio llenado de tabla para seguros tanto para Grupo promo y Grupo no promo
   create table #ca_seguro_externo_tmp	(
   id                       int identity,
   se_operacion_tmp         int,
   se_banco_tmp             varchar (24),
   se_cliente_tmp           int,
   se_fecha_ini_tmp         datetime,
   se_fecha_ult_intento_tmp datetime,
   se_monto_tmp             money,
   se_estado_tmp            char (1),
   se_tramite_tmp           int,
   se_grupo_tmp             int,
   se_monto_pagado_tmp      money       null,
   se_forma_pago            varchar(16) null,
   se_tipo_seguro           varchar(16) null,
   se_monto_basico          money       null)
   
   insert into #ca_seguro_externo_tmp (
   se_operacion_tmp   , se_banco_tmp            , se_cliente_tmp,
   se_fecha_ini_tmp   , se_fecha_ult_intento_tmp, se_monto_tmp  ,
   se_estado_tmp      , se_tramite_tmp          , se_grupo_tmp  ,
   se_monto_pagado_tmp, se_forma_pago           , se_tipo_seguro,
   se_monto_basico  )
   select                                                                  
   @w_operacion ,      @w_banco                 , cliente       ,
   @w_fecha_proceso   , @w_fecha_pro_orig       , sum(monto)    ,
   'C'                , tramite                 , null          , 
   pago=sum(isnull(monto_pag,0)), case when sum(isnull(monto_pag,0)) >0 then max(forma_pago) else null end,
   tipo_seguro, monto_basico
   from #seguros
   group by tramite, cliente, tipo_seguro, monto_basico
   
   --Encuentro el monto de los seguros
   select @w_monto_seguro_basico=sum(isnull(se_monto_tmp,0)-isnull(se_monto_pagado_tmp,0))
   from #ca_seguro_externo_tmp
   select @w_monto_seguro_basico
   
   --Inserccion en tablas fisicas de seguro
   delete from cob_cartera..ca_seguro_externo
   where se_tramite   = @w_tramite
    
   insert into ca_seguro_externo (
   se_operacion,            se_banco,                   se_cliente,
   se_fecha_ini,            se_fecha_ult_intento,       se_monto  ,
   se_estado,               se_tramite,                 se_grupo  ,
   se_monto_pagado,         se_forma_pago,              se_tipo_seguro,
   se_monto_basico,         se_usuario,                 se_terminal)
   select 
   se_operacion_tmp,        se_banco_tmp,               se_cliente_tmp,
   se_fecha_ini_tmp,        se_fecha_ult_intento_tmp,   case when se_monto_tmp >=0 then se_monto_tmp else 0 end ,
   se_estado_tmp,           se_tramite_tmp,             se_grupo_tmp,
   se_monto_pagado_tmp,     se_forma_pago ,             se_tipo_seguro,
   se_monto_basico,         @s_user,                    @s_term
   from #ca_seguro_externo_tmp
   
   if (@@error <>0) begin
       select @w_error = 724637
       goto ERROR
   end
   
   
   
 --Fin Llenado de tabla de seguros



end   -- FIN DE OPERACION U



return 0


ERROR:

exec cobis..sp_cerror 
@t_from  = @w_sp_name, 
@i_num   = @w_error
return @w_error

go





