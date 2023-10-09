use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_cuentas_gar')
drop proc sp_cuentas_gar
go

create proc sp_cuentas_gar
   @i_filial   int = 1
as
declare
   @w_tc_oficina        int,
   @w_tc_tipo_bien      char(1),
   @w_tc_op_clase       char(1),
   @w_tc_moneda         int,
   @w_tc_calificacion   char(1),
   @w_tc_clase_custodia char(1),
   @w_tc_tipo           descripcion,
   @w_tc_codvalor       int,
   @w_tc_valor          money,
   @w_ente              int,
   @w_dp_cuenta         varchar(60),
   @w_dp_area           varchar(10),
   @w_anexo             varchar(255),
   @w_valor_nal         float,
   @w_valor_ext         float,
   @w_error             int,
   @w_cotizacion        float,
   @w_re_area           smallint,
   @w_cuenta_final      varchar(60),
   @w_cuenta_finalc     varchar(60),
   @w_adicional         varchar(50),
   @w_fecha             varchar(10),
   @w_cuen_dc		int,
   @w_cuen_d		int,
   @w_cuen_c		int

   --TABLA DE ERRORES
   truncate table cu_error_contagar

   select @w_fecha = convert(varchar(10),getdate(),101)



select @w_cuen_dc = count(distinct convert(varchar(10),tc_codvalor) + dp_debcred)
       from   cob_custodia..cu_tmp_contagar_mes, 
	      cob_conta..cb_det_perfil
       where  dp_codval 	= tc_codvalor
       and    dp_producto 	= 19
       and    dp_perfil   	= 'GAR'

select @w_cuen_d = count(distinct tc_codvalor)
       from   cob_custodia..cu_tmp_contagar_mes, 
	      cob_conta..cb_det_perfil
       where  dp_codval 	= tc_codvalor
       and    dp_producto 	= 19
       and    dp_perfil   	= 'GAR'
       and    dp_debcred	= '1'

select @w_cuen_c = count(distinct tc_codvalor)
       from   cob_custodia..cu_tmp_contagar_mes, 
	      cob_conta..cb_det_perfil
       where  dp_codval 	= tc_codvalor
       and    dp_producto 	= 19
       and    dp_perfil   	= 'GAR'
       and    dp_debcred	= '2'

if (@w_cuen_dc <> (@w_cuen_c + @w_cuen_d ))
begin
      print 'Error en perfil de garantias'
      return  607124
end

create table #cr_cuentas_ajuste
(
cuenta	 varchar(24),
contra	 varchar(24),
area	 smallint,
ente     int
)
   

   declare cVal cursor
   for select distinct tc_tipo_bien,    tc_op_clase,         	tc_moneda,
              tc_calificacion, 		tc_clase_custodia,   	tc_tipo,		tc_codvalor,     
	      dp_cuenta,		dp_area,                isnull((select cg_ente 
                                                                 from   cob_custodia..cu_cliente_garantia
                                                                 where  cg_codigo_externo = cu_tmp_contagar_det_mes.tc_codigo_externo ),0)
       from   cu_tmp_contagar_det_mes, 
	      cob_conta..cb_det_perfil
       where  dp_codval 	= tc_codvalor
       and    dp_producto 	= 19
       and    dp_perfil   	= 'GAR'
       and    dp_debcred	= '1'
       order by tc_tipo_bien ,tc_op_clase ,tc_moneda   ,tc_calificacion ,tc_clase_custodia , tc_tipo,tc_codvalor 
   
   
   open cVal
   fetch cVal
   into  @w_tc_tipo_bien,      @w_tc_op_clase,       @w_tc_moneda,
         @w_tc_calificacion,   @w_tc_clase_custodia, @w_tc_tipo,
         @w_tc_codvalor,       @w_dp_cuenta,         @w_dp_area, @w_ente 
   while (@@fetch_status = 0)
   begin

      if @w_dp_cuenta is not null
      begin
         select @w_cuenta_final = ''
         exec @w_error = sp_resuelve_param
              @i_filial            = @i_filial,
              @i_tc_tipo_bien      = @w_tc_tipo_bien,
              @i_tc_op_clase       = @w_tc_op_clase,
              @i_tc_moneda         = @w_tc_moneda,
              @i_tc_calificacion   = @w_tc_calificacion,
              @i_tc_clase_custodia = @w_tc_clase_custodia,
              @i_tc_tipo           = @w_tc_tipo,
              @i_cuenta_orig       = @w_dp_cuenta,
              @o_cuenta_dest       = @w_cuenta_final out
         
         if @w_error != 0 
         begin
	    select @w_anexo = ''
	    select @w_cuenta_final = ''
	    select @w_anexo = 'Error en sp_resuelve_param'
            goto  ERROR_CUADRE
         end

         select @w_re_area = ta_area
         from   cob_conta..cb_tipo_area
         where  ta_empresa  = @i_filial
         and    ta_producto = 19
         and    ta_tiparea  = @w_dp_area

         if @w_tc_oficina = 9000
            select @w_re_area = 3030
        
         if @w_tc_oficina = 3029
            select @w_re_area = 3029

	select @w_dp_cuenta = dp_cuenta
	from   cob_conta..cb_det_perfil
	where  dp_codval 	= @w_tc_codvalor
	and    dp_producto 	= 19
	and    dp_perfil   	= 'GAR'
	and    dp_debcred	= '2'

         select @w_cuenta_finalc = ''
         exec @w_error = sp_resuelve_param
              @i_filial            = @i_filial,
              @i_tc_tipo_bien      = @w_tc_tipo_bien,
              @i_tc_op_clase       = @w_tc_op_clase,
              @i_tc_moneda         = @w_tc_moneda,
              @i_tc_calificacion   = @w_tc_calificacion,
              @i_tc_clase_custodia = @w_tc_clase_custodia,
              @i_tc_tipo           = @w_tc_tipo,
              @i_cuenta_orig       = @w_dp_cuenta,
              @o_cuenta_dest       = @w_cuenta_finalc out
         
         if @w_error != 0 
         begin
	    select @w_anexo = ''
	    select @w_cuenta_final = ''
	    select @w_anexo = 'Error en sp_resuelve_param'
            goto  ERROR_CUADRE
         end

         insert into #cr_cuentas_ajuste values
         (@w_cuenta_final , @w_cuenta_finalc, @w_re_area ,@w_ente )


         --Insertar Detalle BD de Cuadre emg
      end
      ELSE
      begin
         select @w_anexo = ''
	 select @w_anexo = 'No existe cuenta'   
         select @w_anexo = @w_anexo + '   OFI: ' + convert(varchar(4), @w_tc_oficina)
         select @w_anexo = @w_anexo + '  CUENTA : SIN CUENTA PARA CODIGO VALOR 22'
         select @w_anexo = @w_anexo + '  AREA : ' + convert(varchar(6), @w_dp_area)
         select @w_anexo = @w_anexo + '  MONEDA : ' + convert(varchar(3), @w_tc_moneda)
         select @w_anexo = @w_anexo + '  VALOR : ' + convert(varchar(30), @w_tc_valor)
         
         goto ERROR_CUADRE
      end

      goto SIGUIENTE

      ERROR_CUADRE:
      insert into cu_error_contagar
      (ec_fecha_proc,  ec_cta_contable,  ec_cta_final,  ec_error)
      values (@w_fecha,@w_dp_cuenta,@w_cuenta_final, @w_anexo)
      SIGUIENTE: 
   fetch cVal
   into  @w_tc_tipo_bien,      @w_tc_op_clase,       @w_tc_moneda,
         @w_tc_calificacion,   @w_tc_clase_custodia, @w_tc_tipo,
         @w_tc_codvalor,       @w_dp_cuenta,         @w_dp_area, @w_ente 
   end
   close cVal
   deallocate cVal

truncate table cu_cuentas_ajuste

insert into cu_cuentas_ajuste
select	distinct cuenta,
	contra,
	"OF",
	area,
	"V",
	getdate(),
	"crebatch",
	19,
	"C",
        ente
from	#cr_cuentas_ajuste 
go