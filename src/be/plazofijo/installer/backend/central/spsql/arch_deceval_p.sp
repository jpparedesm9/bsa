/*****************************************************************************/
/*  ARCHIVO:         arch_deceval_p.sp                                       */
/*  NOMBRE LOGICO:   sp_arch_deceval_p                                       */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Enviar la informacion para DECEVAL.                                       */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_arch_deceval_p')
   drop proc sp_arch_deceval_p
go

create proc sp_arch_deceval_p (
@t_debug             varchar(1)   = null)
with encryption
as
declare
@w_error             int,
@w_msg               descripcion,
@w_ag_deceval        varchar(4),
@w_fecha_proc        datetime,
@w_fecha_arch        varchar(8),
@w_sec               int,
@w_sec_char          varchar(10),
@w_tab               char(1),
@w_sec_registro      int,
@w_archivo           descripcion,
@w_archivo_bcp       descripcion,
@w_errores           descripcion,
@w_operacion_ant     int,
@w_operacion         int,
@w_toperacion        catalogo,
@w_fpago             catalogo,
@w_ppago             catalogo,
@w_monto             money,
@w_fungible          varchar(30),
@w_tasa_variable     char(1),
@w_fecha_valor       datetime,
@w_fecha_ven         datetime,
@w_mnemonico_tasa    catalogo,
@w_spread            float,
@w_tasa              float,
@w_ente              int,
@w_oficina           int,
@w_num_serie              varchar(30),
@w_meses             varchar(10),
@w_tasa_dcv          varchar(30),
@w_rol               catalogo,
@w_condicion         char(1),
@w_num_beneficiarios int,
@w_cont              int,
@w_tipo_doc          char(2),
@w_ced_ruc           numero,
@w_subtipo           char(1),
@w_tipo_cia          varchar(10),
@w_fecha_nac         datetime,
@w_retencion         char(1),
@w_asociada          catalogo,
@w_autoretenedor     char(1),
@w_nombre            descripcion,
@w_sector            varchar(10),
@w_sector_dcv        varchar(2),
@w_tipo_doc_dcv      catalogo,
@w_direccion         tinyint,
@w_descripcion       varchar(254),
@w_ciudad            varchar(10),
@w_ciudad_dcv        varchar(10),
@w_provincia         varchar(10),
@w_telefono          varchar(10),
@w_tot_reg           int,
@w_path_s_app        varchar(30),
@w_path              varchar(250),
@w_s_app             varchar(250),
@w_cmd               varchar(250),
@w_bd                varchar(250),
@w_tabla             varchar(250),
@w_comando           varchar(250),
@w_registro          varchar(999),
@w_actividad         varchar(30),
@w_op_operador       varchar(10),
@w_suc_dcv           varchar(10),
@w_ano_emision	     datetime,
@w_op_base_calculo   int,
@w_dcv_anna	     char(1),
@w_campo_32 	     varchar(20),
@w_campo_33 	     varchar(20),
@w_campo_34 	     varchar(20),
@w_actividad_aux     varchar(30)



select @w_ag_deceval = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'AGDCVL'
and    pa_producto = 'PFI'

if @w_ag_deceval is null begin
   select @w_msg = 'NO ESTA DEFINIDO EL PARAMETRO AGENCIA DECEVAL'
   goto ERROR
end

select @w_suc_dcv = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'SUDCVL'
and    pa_producto = 'PFI'

select @w_dcv_anna = isnull(pa_char,'N')
from   cobis..cl_parametro
where  pa_nemonico = 'DCVANN'
and    pa_producto = 'PFI'


if @w_ag_deceval is null begin
   select @w_msg = 'NO ESTA DEFINIDO EL PARAMETRO SUCURSAL DECEVAL'
   goto ERROR
end

select @t_debug = 'S'

if @t_debug = 'S' print 'entra a generar archivo p'

/* BORRO LO EXISTENTE EN LA TABLA CON LOS DATOS A ENVIAR */
truncate table pf_archivo_deceval

/* OBTENGO LA FECHA DE PROCESO */
select
@w_fecha_proc = fp_fecha,
@w_fecha_arch = convert(varchar, fp_fecha, 112)
from cobis..ba_fecha_proceso

/* OBTENGO EL SECUENCIAL A GENERAR */
select @w_sec = max(ed_secuencial) + 1
from   pf_envios_dcv
where  ed_fecha = @w_fecha_proc

select
@w_sec_registro = 0,
@w_sec          = isnull(@w_sec, 1),
@w_tab          = char(9) --LE ASIGNO A LA VARIABLE TAB EL CARACTER TABULADOR


select @w_sec_char = replicate ('0', 3-datalength(convert(varchar, @w_sec)))+convert(varchar, @w_sec)

select
@w_archivo      = 'P' + @w_ag_deceval + substring(@w_fecha_arch, 5, 4) +'.' + @w_sec_char,
@w_errores      = 'E' + @w_ag_deceval + substring(@w_fecha_arch, 5, 4) +'.' + @w_sec_char

/* PARA HACER EL PROCESO REPROCESABLE BORRO LOS ARCHIVOS QUE PUDIERON QUEDAR DE
UNA CORRIDA CON ERROR */

if @t_debug = 'S' print '@w_archivo ' + cast(@w_archivo as varchar)


delete pf_det_envios_dcv
where  de_archivo = @w_archivo

if @@error <> 0 begin
   select @w_msg = 'ERROR EN ELIMINACION DE DETALLE DE ENVIO DECEVAL'
   goto ERROR
end


if @t_debug = 'S' print '@w_dcv_anna ' + cast(@w_dcv_anna as varchar)

/* CONSULTO OPERACIONES DESMATERIALIZADAS QUE NO TIENEN FUNGIBLE ASIGNADO */

if @w_dcv_anna = 'S'
begin
	declare cur_ope cursor for
	select
	op_operacion,      op_toperacion,     op_fpago,
	op_ppago,          op_monto,          op_fungible,
	op_tasa_variable,  op_fecha_valor,    op_fecha_ven,
	op_mnemonico_tasa, op_spread,         op_ente,
	op_oficina,        op_tasa,           op_operador,
	op_base_calculo
	from   pf_operacion
	where  op_desmaterializa = 'S'
	and    op_isin      is null
	and    op_estado        =  'ACT'
end
else
begin
	declare cur_ope cursor for
	select
	op_operacion,      op_toperacion,     op_fpago,
	op_ppago,          op_monto,          op_fungible,
	op_tasa_variable,  op_fecha_valor,    op_fecha_ven,
	op_mnemonico_tasa, op_spread,         op_ente,
	op_oficina,        op_tasa,           op_operador,
	op_base_calculo
	from   pf_operacion
	where  op_desmaterializa = 'S'
	and    op_fungible      is null
	and    op_estado        =  'ACT'
end

open cur_ope

fetch cur_ope into
@w_operacion,      @w_toperacion,     @w_fpago,
@w_ppago,          @w_monto,          @w_fungible,
@w_tasa_variable,  @w_fecha_valor,    @w_fecha_ven,
@w_mnemonico_tasa, @w_spread,         @w_ente,
@w_oficina,        @w_tasa,           @w_op_operador,
@w_op_base_calculo

while @@fetch_status = 0
begin

if @t_debug = 'S' print ' w_operacion ' + cast (@w_operacion as varchar)

   /* SOLO PERMITO UN REENVIO SI SE TRATA DE UN RECHAZADO */
   if exists (select 1
   from pf_det_envios_dcv
   where de_operacion = @w_operacion
   and   de_estado   in ('A','I')) begin
      goto SIGUIENTE_OP
   end


--select @w_oficina = 0


   /* OBTENGO EL 'ISIN' DE ACUERDO AL TIPO DE DEPOSITO */
   select @w_num_serie = td_num_serie
   from   pf_tipo_deposito
   where  td_mnemonico = @w_toperacion

if @t_debug = 'S' print ' w_num_serie ' + cast (@w_num_serie as varchar)


   if @w_num_serie is null begin
      select @w_msg = 'NO EXISTE NUM SERIE PARA EL TIPO DE DEPOSITO ' + @w_toperacion
      goto ERROR_OP
   end


   /* OBTENGO LOS MESES DE ACUERDO AL PERIODO DE PAGO */
   if @w_fpago = 'PER' begin
      select @w_meses = convert(varchar, pp_factor_en_meses)
      from   pf_ppago
      where  pp_codigo = @w_ppago
   end

   if @w_meses is null select @w_meses = '99'

   /* OBTENGO TIPO DE TASA TOMANDOLA DE LA TABLA DE EQUIVALENCIAS */
   if @w_tasa_variable = 'S' begin
      select @w_tasa_dcv = eq_val_interfaz
      from   pf_equivalencias
      where  eq_val_pfijo = @w_mnemonico_tasa
      and    eq_modulo    = 99
      and    eq_tabla     = 'DCVTASA'

      select @w_tasa_dcv = isnull( @w_tasa_dcv, '0001')
   end
   if  @w_tasa_dcv is null select @w_tasa_dcv = '0000'

   /* OBTENGO EL NUMERO DE BENEFICIARIOS QUE NO SON TITULARES */
   select @w_num_beneficiarios = count(*)
   from   pf_beneficiario
   where  be_operacion = @w_operacion
   and    be_estado    = 'I'
   and    be_rol      <> 'T'
   and    be_tipo     <> 'F'

if @t_debug = 'S' print ' w_num_beneficiarios ' + cast (@w_num_beneficiarios as varchar)

   select @w_operacion_ant = -1

   /* RECORRO LOS BENEFICIARIOS DE LAS OPERACIONES  */
   declare cur_benef cursor for
   select
   be_ente,     be_rol,   be_condicion
   from  pf_beneficiario
   where be_operacion = @w_operacion
   and   be_estado    = 'I'
   and   be_tipo     <> 'F'
   order by be_rol desc

   open cur_benef

   fetch cur_benef into
   @w_ente,     @w_rol,   @w_condicion

   while @@fetch_status = 0
   begin
      if @w_operacion <> @w_operacion_ant begin
         select @w_cont = 0,
                @w_operacion_ant = @w_operacion
      end

      select @w_cont = @w_cont + 1

if @t_debug = 'S' print ' w_rol ' + cast (@w_rol as varchar)
if @t_debug = 'S' print ' w_cont ' + cast (@w_cont as varchar)
if @t_debug = 'S' print ' w_ente ' + cast (@w_ente as varchar)


      /* SOLO PUEDO ENVIAR HASTA 3 BENEFICIARIOS */
      if @w_cont > 4 begin
         goto SIGUIENTE_BE
      end

      select
      @w_tipo_doc   = en_tipo_ced,
      @w_ced_ruc    = en_ced_ruc,
      @w_subtipo    = en_subtipo,
      @w_fecha_nac  = p_fecha_nac,
      @w_retencion  = en_retencion,
      @w_nombre     = en_nomlar,
      @w_asociada   = en_asosciada,
      @w_tipo_cia   = case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end,
      @w_sector     = en_sector,
      @w_actividad  = en_actividad
      from   cobis..cl_ente
      where  en_ente      = @w_ente

      /* por solicitud del banco se realiza este ajuste ya que el NI en produccion aparece como person natural y en deceval aparee como persona juridica */
     
      if @w_tipo_doc = 'NI' 
         select @w_subtipo = 'C'	

      select @w_tipo_doc_dcv = eq_val_interfaz
      from   pf_equivalencias
      where  eq_val_pfijo = @w_tipo_doc
      and    eq_modulo    = 99
      and    eq_tabla     = 'DCVTDOC'

      if @w_tipo_doc_dcv is null begin
         select @w_msg = 'NO ESTA DEFINIDA EQUIVALENCIA PARA DECEVAL DE TIPO DE DOCUMENTO '+@w_tipo_doc
         goto ERROR_BE
      end

      select
      @w_direccion   = di_direccion,
      @w_descripcion = di_descripcion,
      @w_ciudad      = convert(varchar, di_ciudad),
      @w_provincia   = convert(varchar, isnull(di_provincia,0))
      from   cobis..cl_direccion
      where  di_ente      = @w_ente
      and    di_principal = 'S'

      if @@rowcount = 0  begin
         select @w_msg = 'CLIENTE NO TIENE DIRECCION PRINCIPAL - '+convert(varchar, @w_ente)
         goto ERROR_BE
      end

      if @w_provincia = null or @w_provincia = '0' begin
         select @w_provincia = substring(convert(varchar(10),(of_ciudad)),1,2) from cobis..cl_oficina where of_oficina  = @w_oficina
      end

      select @w_actividad_aux = eq_val_interfaz
      from   pf_equivalencias
      where  eq_val_pfijo = @w_actividad
      and    eq_modulo    = 99
      and    eq_tabla     = 'DCVACTEC'

if @t_debug = 'S' print ' w_actividad_aux ' + cast (@w_actividad_aux as varchar)

	if @w_actividad_aux = null or @w_actividad_aux = ''
		select @w_actividad  = 80
	else
		select @w_actividad  = @w_actividad_aux 


if @t_debug = 'S' print ' w_ciudad ' + @w_ciudad
      select @w_ciudad_dcv = eq_val_interfaz
      from   pf_equivalencias
      where  eq_val_pfijo = @w_ciudad
      and    eq_modulo    = 99
      and    eq_tabla     = 'DCVCIUD'

if @t_debug = 'S' print ' w_ciudad_dcv ' + @w_ciudad_dcv

      if @w_ciudad_dcv is null begin
         select @w_msg = 'NO ESTA DEFINIDA EQUIVALENCIA PARA DECEVAL DE CIUDAD '+@w_ciudad
         goto ERROR_BE
      end

      if @w_subtipo <> 'P' begin
         select @w_sector_dcv = eq_val_interfaz
         from   pf_equivalencias
         where  eq_val_pfijo = @w_sector
         and    eq_modulo    = 99
         and    eq_tabla     = 'DCVSECT'

if @t_debug = 'S' print ' w_sector_dcv ' + cast (@w_sector_dcv as varchar)

         if @w_sector_dcv is null begin
            select @w_msg = 'NO ESTA DEFINIDA EQUIVALENCIA PARA DECEVAL DE SECTOR '+@w_sector
            goto ERROR_BE
         end

      end
      if @w_sector_dcv is null select @w_sector_dcv = '11'--N/A

      select
      @w_telefono = ltrim(rtrim(te_valor))
      from  cobis..cl_telefono
      where te_ente      = @w_ente
      and   te_direccion = @w_direccion

      select @w_autoretenedor = rf_autorretenedor
      from   cob_conta..cb_regimen_fiscal
      where  rf_codigo   = @w_asociada

      select @w_autoretenedor = isnull(@w_autoretenedor, 'N')

      select @w_ano_emision = datepart(yy,@w_fecha_valor)

      select @w_registro = ''
      /* SI ES EL TITULAR INGRESO LOS REGISTROS 01 y 02 */
      if @w_rol = 'T' begin


         /********************/
         /* REGISTRO TIPO 01 */
         /********************/


         select @w_sec_registro = @w_sec_registro + 1

         select @w_registro =
         replicate('0', 8-datalength(convert(varchar, @w_sec_registro)))+convert(varchar, @w_sec_registro) + @w_tab +   -- 1 Secuencia
         '01' + @w_tab +                                    								-- 2 TIPO DE REGISTRO
         replicate('0', 15-datalength(convert(varchar, @w_operacion)))+convert(varchar, @w_operacion) + @w_tab +  	-- 3 Nunmerod e control (pf_operacion  )
         convert(varchar, convert(numeric, @w_monto * 10000)) + @w_tab +                  				-- 4 Monto
         replicate('0', 4-datalength(convert(varchar, @w_ag_deceval)))+convert(varchar, @w_ag_deceval) + @w_tab +    	-- 5 COD COLOCACION  BANCAMIA
         replicate('0', 4-datalength(convert(varchar, @w_ag_deceval)))+convert(varchar, @w_ag_deceval) + @w_tab +    	-- 6 COD COLOCACION  BANCAMIA
         '1' + @w_tab +                                     								-- 7 LIBRE DE PAGO
         '0' + @w_tab +                                     								-- 8 SIN BLOQUEO
         convert(varchar, convert(numeric, @w_monto * 10000)) + @w_tab +                  				-- 9 Monto valora a cobrar
         '00000000000000000000' + @w_tab +                                                     				--10 CEBRA VENDEDOR
         '00000000000000000000' + @w_tab +                         							--11 CEBRA COMPRADOR
         @w_num_serie + @w_tab +                                        							--12 ISIN o SERIEMDE EMISION (OJO ES ALFABETICO)
         case when @w_dcv_anna = 'S' then '0' else '0000000000' end + @w_tab  +                                  	   							--13 FUNGIBLE
         case when @w_tasa_variable = 'S' then '2' else '1' end + @w_tab +                				--14 TIPO TASA
         isnull(case when @w_fpago = 'VEN' then '00' else replicate('0', 2-datalength(convert(varchar, @w_meses)))+convert(varchar, @w_meses) end, '00') + @w_tab +     --15 Periodicidad
         convert(varchar, @w_fecha_valor, 112) + @w_tab +                        					--16 Fecha valor
         convert(varchar, @w_fecha_ven,   112) + @w_tab +                        					--17 Fecha Ven
         '2' + @w_tab +                                        								--18 MODALIDAD PAGO VENCIDO
         '1' + @w_tab +                                        								--19 TIPO DE PAGO PAGADERO (NO CAPITALIZABLE)
         '2' + @w_tab +                                        								--20 INDICADOR DE TASA NOMINAL                --20
         case    when @w_tasa_variable = 'S' then '000000' else replicate('0', 6-datalength(convert(varchar, convert(varchar, convert(numeric, @w_tasa * 10000))))) + convert(varchar, convert(numeric, @w_tasa * 10000))  end + @w_tab + --21 Tipo Tasa
         '000' + @w_tab +                                      								--22 OPERADOR
         case when @w_tasa_variable = 'S' then  replicate('0', 4-datalength(convert(varchar, isnull(@w_tasa_dcv, '0000'))))+convert(varchar, isnull(@w_tasa_dcv, '0000')) else '0000' end + @w_tab +        --23 Cod TIPO TASA
         case when @w_tasa_variable = 'S' then '0001' else '0000' end + @w_tab +                			--24 VIGENCIA RENDIMIENTOS
         '0000' + @w_tab +  --VIGENCIA FINAL                                                 				--25 Vigencia Final
         case when @w_tasa_variable = 'S' then @w_op_operador + replicate('0', 6-datalength(convert(varchar, convert(varchar, convert(numeric, @w_spread * 10000))))) + convert(varchar, convert(numeric, @w_spread * 10000)) else '0000000' end  + @w_tab +  -- 26 spread
         '00000000' + @w_tab +                                    							--27 CTA INVERSIONISTA
         @w_tipo_doc_dcv + @w_tab +                               							--28 TIPO DOC
         @w_ced_ruc + @w_tab +                                    							--29 NUM DOC
         case when @w_num_beneficiarios = 0 then '3' when @w_condicion = 'Y' then '1' else '2' end + @w_tab +        	--30 CONDICION
         replicate('0', 6-datalength(convert(varchar, convert(varchar, convert(numeric, @w_oficina)))))  + convert(varchar, @w_oficina)  	--31 OFICINA DECEVAL BOGOTA


	

	if @w_dcv_anna = 'S' 
	begin

		select @w_campo_32 = isnull(pa_char,'N')
		from   cobis..cl_parametro
		where  pa_nemonico = 'CODEM'	-- Codigo emisor
		and    pa_producto = 'PFI'

		select @w_campo_33 = isnull(pa_char,'N')
		from   cobis..cl_parametro
		where  pa_nemonico = 'CLATI'	-- Clase Titulo
		and    pa_producto = 'PFI'

		select @w_campo_34 = isnull(pa_char,'N')
		from   cobis..cl_parametro
		where  pa_nemonico = 'ANOEMI'	-- Año Emision
		and    pa_producto = 'PFI'


         	select @w_registro = @w_registro + @w_tab + 
         		@w_campo_32 + @w_tab + 												--32 EMISOR
         		@w_campo_33 + @w_tab + 												--33 CALSE TITULO
         		convert(varchar,@w_campo_34) + @w_tab + 									--34 AÑO
         		case when @w_op_base_calculo = 360 then '1' else '2' end							--35 Base de liquidacion
	end		     
	
if @t_debug = 'S' print ' w_registro ' + @w_registro


         insert into pf_archivo_deceval(ad_registro)
         values (@w_registro)

         if @@error <> 0 begin
            select @w_msg = 'ERROR EN INSERCION DE REGISTRO 01'
            goto ERROR_BE
         end


         /********************/
         /* REGISTRO TIPO 02 */
         /********************/


         select @w_registro = ''
         select @w_sec_registro = @w_sec_registro + 1

         select @w_registro =
         replicate('0', 8-datalength(convert(varchar, @w_sec_registro)))+convert(varchar, @w_sec_registro) + @w_tab +   	-- 1 Secuencia
         '02' + @w_tab +                              										-- 2 TIPO DE REGISTRO
         convert(varchar, isnull(@w_tipo_doc_dcv, '0')) + @w_tab + 								-- 3 TIPO ID CARACTER
         replicate('0', 15-datalength(convert(varchar, isnull(@w_ced_ruc, '0'))))+convert(varchar, isnull(@w_ced_ruc, '0')) + @w_tab + -- 4 NUM ID
         case when @w_subtipo = 'P' then  '1' else '2' end + @w_tab +                        					-- 5 persona nat o jurid
         case when @w_subtipo = 'P' then  '099' else  /*replicate('0', 3-datalength(isnull(@w_actividad, '0')))+*/isnull(@w_actividad,'0') end + @w_tab +                      -- 6 Actividad economcia
         isnull(upper(substring(@w_nombre, 1, 50)), '                                                  ') + @w_tab +            -- 7 Nombre
         case when @w_autoretenedor = 'N' then '1' else '2' end + @w_tab +          						-- 8 Todos NO Autorretenedor
         isnull(upper(substring(@w_descripcion, 1, 50)), '                                                  ') + @w_tab +       -- 9 Direccion
         isnull(substring(ltrim(rtrim(@w_telefono)), 1, 10),'0000000000') + @w_tab +                    				--10 Nu telefono
         'CO' + @w_tab +                              										--11 PAIS
         replicate('0', 4-datalength(@w_provincia))  + @w_provincia  + @w_tab +              					--12 COD Departamento
         replicate('0', 4-datalength(@w_ciudad_dcv)) + @w_ciudad_dcv + @w_tab +              					--13 COD ciudad
         case when @w_num_beneficiarios = 0 then '3' when @w_condicion = 'Y' then '1' else '2' end + @w_tab + 			--14 INDICARDOR MANCOMUNADOS
         @w_suc_dcv + @w_tab +                        										--15 SUCURSAL DECEVAL                                    			
         'S' + @w_tab +                               										--16 RESIDENCIA S/N
         '1' + @w_tab +                               										--17 TIPO INVERSIONISTA TITULAR
         case when @w_subtipo = 'P' then  '1' else '2' end + @w_tab +                        					--18 RETIENE IMP
         '000009999999' + @w_tab +                             									--19  NUMERO DE FAX
         case when @w_tipo_doc_dcv = 'TI' then '2' else '1' end + @w_tab +             						--20 MAYOR DE EDAD --20
         case when @w_subtipo = 'P' then '011' else replicate('0', 3-datalength(convert(varchar, isnull(@w_sector_dcv, '011'))))+convert(varchar, isnull(@w_sector_dcv, '011')) end + @w_tab +     --21 SECTOR / ACTIVIDAD
         case when @w_subtipo = 'P' then '4' when @w_subtipo = 'C' and @w_tipo_cia = 'OF' then  '1' when @w_subtipo = 'C' and @w_tipo_cia = 'PA' then '2' else '4' end  -- 22 TIPO ENTIDAD
         
         if @w_dcv_anna = 'S' 
         	select 	@w_registro = @w_registro + @w_tab +  
         		case when @w_subtipo = 'P' then  '2' else '1' end                         					

if @t_debug = 'S' print ' w_registro 2 ' + @w_registro

         insert into pf_archivo_deceval(ad_registro)
         values (@w_registro)

         if @@error <> 0 begin
            select @w_msg = 'ERROR EN INSERCION DE REGISTRO 02'
            goto ERROR_BE
         end

      end else begin --NO ES TITULAR


         /********************/
         /* REGISTRO TIPO 03 */
         /********************/


         select @w_registro = ''

         select @w_sec_registro = @w_sec_registro + 1

         select  @w_registro =
         replicate('0', 8-datalength(convert(varchar, @w_sec_registro)))+convert(varchar, @w_sec_registro) + @w_tab +   	-- 1 Secuencia
         '03' + @w_tab +                        										--2 TIPO DE REGISTRO
         '1' + @w_tab +                         										--3 DATOS DEL MANCOMUNADO
         convert(varchar, isnull(@w_tipo_doc_dcv, '0')) + @w_tab + 								-- 3 TIPO ID
         replicate('0', 15-datalength(convert(varchar, isnull(@w_ced_ruc, '0'))))+convert(varchar, isnull(@w_ced_ruc, '0')) + @w_tab + -- 4 NUM ID
         case when @w_subtipo = 'P' then '1' else '2' end + @w_tab +       							--6 clase persona
         '001' + @w_tab +                       										--7 ESTABLECIMIENTO BANCARIO
         isnull(upper(substring(@w_nombre, 1, 50)),      '                                                  ') + @w_tab +     	--8 Nombre
         isnull(substring(rtrim(ltrim(@w_telefono)), 1, 10),    '0000000000') + @w_tab +   						--9 telefono
         isnull(upper(substring(@w_descripcion, 1, 50)), '                                                  ') + @w_tab +       --10
         replicate('0', 2-datalength(convert(varchar, isnull(@w_cont, '0'))))+convert(varchar, isnull(@w_cont, '0')) + @w_tab + -- 11 ORDEN DEL BENEFICIARIO
	 case when @w_subtipo = 'P' then '4' when @w_subtipo = 'C' and @w_tipo_cia = 'OF' then  '1' when @w_subtipo = 'C' and @w_tipo_cia = 'PA' then '2' else '4' end + @w_tab +          --12 TIPO ENTIDAD PRIVADA
         case when @w_subtipo = 'P' then '11' else replicate('0', 2-datalength(convert(varchar, isnull(@w_sector_dcv, '11'))))+convert(varchar, isnull(@w_sector_dcv, '11')) end       --13 SECTOR / ACTIVIDAD

if @t_debug = 'S' print ' w_registro 3 ' + cast (@w_registro as varchar)


         insert into pf_archivo_deceval(ad_registro)
         values (@w_registro)

         if @@error <> 0 begin
            select @w_msg = 'ERROR EN INSERCION DE REGISTRO 03'
            goto ERROR_BE
         end
      end

      goto SIGUIENTE_BE

      ERROR_BE:
      /* SI HUBO ERROR AL REGISTRAR ALGUN TITULAR BENEFICIARIO PASO A LA SIGUIENTE OPERACION REGISTRANDO EL ERROR */

      close cur_benef
      deallocate cur_benef
      goto ERROR_OP

      SIGUIENTE_BE:
      fetch cur_benef into
      @w_ente,     @w_rol,   @w_condicion
   end --cursor

   close cur_benef
   deallocate cur_benef


if @t_debug = 'S' print ' w_archivo ' + cast (@w_archivo as varchar)
if @t_debug = 'S' print ' w_fecha_proc ' + cast (@w_fecha_proc as varchar)
if @t_debug = 'S' print ' w_operacion ' + cast (@w_operacion as varchar)


   insert into pf_det_envios_dcv(
   de_archivo,   de_fecha,      de_operacion,
   de_estado)
   values(
   @w_archivo,   @w_fecha_proc, @w_operacion,
   'I')

   if @@error <> 0 begin
      select @w_msg = 'ERROR EN INSERCION DE DETALLE DE ENVIO'
      goto ERROR_OP
   end

   select @w_operacion_ant = @w_operacion

   goto SIGUIENTE_OP

   ERROR_OP:

   select @w_descripcion = 'DECEVAL '+isnull(convert(varchar, @w_operacion), '')+ isnull(' CLIENTE:'+convert(varchar, @w_ente), '')
   exec sp_errorlog
   @s_date      = @w_fecha_proc,
   @i_fecha     = @w_fecha_proc,
   @i_error     = 1,
   @i_usuario   = 'operador',
   @i_tran      = 14090,
   @i_cuenta    = @w_descripcion,
   @i_descripcion = @w_msg,
   @i_cta_pagrec  = ''


   SIGUIENTE_OP:
   fetch cur_ope into
   @w_operacion,      @w_toperacion,     @w_fpago,
   @w_ppago,          @w_monto,          @w_fungible,
   @w_tasa_variable,  @w_fecha_valor,    @w_fecha_ven,
   @w_mnemonico_tasa, @w_spread,         @w_ente,
   @w_oficina,        @w_tasa,           @w_op_operador,
   @w_op_base_calculo
end --CURSOR

close cur_ope
deallocate cur_ope

select @w_tot_reg = count(*)
from   pf_det_envios_dcv
where  de_archivo = @w_archivo
and    de_fecha   = @w_fecha_proc


if @t_debug = 'S' print ' w_tot_reg ' + cast (@w_tot_reg as varchar)


if @w_tot_reg > 0 begin

   select @w_path_s_app = pa_char
   from   cobis..cl_parametro
   where  pa_nemonico = 'S_APP'

if @t_debug = 'S' print ' w_path_s_app ' + cast (@w_path_s_app as varchar)


   if @w_path_s_app is null begin
      select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
      goto ERROR
   end

   /* REALIZO BCP */
   select @w_s_app = @w_path_s_app + 's_app'

   select
   @w_path = ba_path_destino
   from  cobis..ba_batch
   where ba_batch = 14090

if @t_debug = 'S' print ' w_path ' + cast (@w_path as varchar)


   select
   @w_archivo_bcp = @w_path  + @w_archivo,
   @w_errores     = @w_path  + @w_errores,
   @w_cmd         = @w_s_app + ' bcp -auto -login cob_pfijo..pf_archivo_deceval out '



   select
   @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_s_app + '.ini'


if @t_debug = 'S' print 'w_comando ' + cast (@w_comando as varchar)

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL GENERAR ARCHIVO '+@w_archivo+ ' '+ convert(varchar, @w_error)
      goto ERROR
   end

   insert into pf_envios_dcv(
   ed_archivo,     ed_fecha,       ed_secuencial,
   ed_estado,      ed_tot_op,      ed_tot_apr,
   ed_tot_rec,     ed_archivo_out)
   values(
   @w_archivo,     @w_fecha_proc,  @w_sec,
   'I',            @w_tot_reg,     null,
   null,           null)

   if @@error <> 0 begin
      select @w_msg = 'ERROR EN INSERCION DE ENVIO DECEVAL'
      goto ERROR
   end

end

return 0
ERROR:

delete pf_det_envios_dcv
where  de_archivo = @w_archivo

if @@error <> 0 begin
   select @w_msg = 'ERROR EN ELIMINACION DE DETALLE DE ENVIO DECEVAL'
   goto ERROR
end

delete pf_envios_dcv
where  ed_archivo = @w_archivo

if @@error <> 0 begin
   select @w_msg = 'ERROR EN ELIMINACION DE ENVIO DECEVAL'
   goto ERROR
end

select @w_descripcion = 'DECEVAL '+isnull(convert(varchar, @w_operacion), '')+ isnull(' CLIENTE:'+convert(varchar, @w_ente), '')

exec sp_errorlog
@s_date      = @w_fecha_proc,
@i_fecha     = @w_fecha_proc,
@i_error     = 1,
@i_usuario   = 'operador',
@i_tran      = 14090,
@i_cuenta    = @w_descripcion,
@i_descripcion = @w_msg,
@i_cta_pagrec  = ''

return 1

go

