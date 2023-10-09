/************************************************************************/
/*	Archivo: 	        poliza.sp                               */
/*	Stored procedure:       sp_poliza                               */
/*	Base de datos:  	cob_custodia				*/ 
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Ingreso / Modificacion / Eliminacion / Consulta y Busqueda      */
/*	de las Polizas de Seguro de las garantias                       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA	   AUTOR		RAZON 				*/
/*      Feb/1996   Luis Castellanos    Emision Inicial		        */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_poliza')
    drop proc sp_poliza
go
create proc sp_poliza (
   @s_ssn                int      =	null,
   @s_sesn               int      =	null,
   @s_rol                int      =	null,
   @s_date               datetime =	null,
   @s_user               login    =	null,
   @s_term               varchar(64) =	null,
   @s_srv                varchar(30) =	null,
   @s_lsrv               varchar(30) =	null,
   @s_corr               char(1)  =	null,
   @s_ssn_corr           int      =	null,
   @s_ofi                smallint =	null,
   @t_rty                char(1)  =	null,
   @t_trn                smallint =	null,
   @t_debug              char(1)  =	'N',
   @t_file               varchar(14) =	null,
   @t_from               varchar(30) =	null,
   @i_operacion          char(1)  =	null,
   @i_modo               smallint =	null,
   @i_aseguradora        varchar( 20)=	null,
   @i_poliza             varchar( 20)=	null,
   @i_fvigencia_inicio   datetime =	null,
   @i_fvigencia_fin      datetime =	null,
   @i_moneda             tinyint  =	null,
   @i_monto_poliza       money    =	null,
   @i_monto_endozo       money    =	null,
   @i_monto_comision     money    =	null,	
   @i_fecha_endozo       datetime =	null,
   @i_fendozo_fin        datetime =	null,
   @i_param1	         varchar(64) =	null,	
   @i_param2	         varchar(64) =	null,
   @i_formato_fecha      int         =	null, --PGA 16/06/2000
   @i_cobertura          catalogo =	null,
   @i_descripcion        varchar(64) =	null,
   @i_filial             tinyint  =	null,
   @i_sucursal           smallint =	null,
   @i_tipo               varchar(64)  =	null,
   @i_custodia           int      =	null,
   @i_codigo_externo     varchar(64) =	null,
   @i_estado_poliza      catalogo =	null,
   @i_renovacion	 char(1)  =	null,
   @i_renovada	         char(1)  =	null,
   @i_cuenta  	         cuenta   =	null,
   @i_tipo_cta	         char(3)  =	null,
   @i_temporal           smallint =	null,	/*INDICA SI YA SE TRANSMITIO*/
   @i_carga              smallint =	null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_aseguradora        varchar( 20),
   @w_poliza             varchar( 20),
   @w_fvigencia_inicio   datetime,
   @w_fvigencia_fin      datetime,
   @w_moneda             tinyint,
   @w_monto_poliza       money,
   @w_fecha_endozo       datetime,
   @w_fendozo_fin        datetime,
   @w_ffin               datetime,
   @w_frenovacion        datetime,
   @w_monto_endozo       money,
   @w_des_moneda         varchar(30),
   @w_des_aseguradora    descripcion,
   @w_des_estado_poliza  catalogo,
   @w_estado_poliza      catalogo,
   @w_error              int,
   @w_salida             int,
   @w_delta              int,
   @w_secservicio        int,
   @w_cobertura          catalogo,
   @w_des_cobertura      varchar(64),
   @w_descripcion        varchar(64),
   @w_mensaje            varchar(120),
   @w_valor_actual       money,
   @w_valor_comparativo  float,
   @w_porcentaje         float,
   @w_monto_comision     money,		
   @w_valor_poliza_aux   money,
   @w_valor_poliza_tot   money,
   @w_codigo_externo     varchar(64),
   @w_moneda_local       tinyint,
   @w_renovacion         char(1),
   @w_cuenta  	         cuenta,
   @w_tipo_cta	         char(3),
   @w_temporal           smallint,	/*INDICA SI YA SE TRANSMITIO*/
   @w_fecha_ingreso      datetime,
   @w_nn      		 datetime,
   @w_sector		 char(1),	
   @w_fpago		 catalogo,	
   @w_fdesembolso	 catalogo,	
   @w_toperacion	 catalogo,	
   @w_cliente	         int,		
   @w_oficial	         int,		
   @w_oficina	         smallint,	
   @w_ciudad	         int,		
   @w_def_moneda         tinyint,
   @w_cont               int,
   @w_pid_cus            int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_poliza'
select @w_pid_cus = @@spid * 100
delete from cu_tmp_cotizacion_monedagar
where  sesion =@w_pid_cus

/*SELECCION DE CODIGO DE MONEDA LOCAL*/
select @w_def_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLOCR'
set transaction isolation level read uncommitted


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A' 
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   select 
   @w_aseguradora      = po_aseguradora,
   @w_poliza           = po_poliza,
   @w_monto_poliza     = po_monto_poliza,
   @w_fvigencia_inicio = po_fvigencia_inicio,
   @w_fvigencia_fin    = po_fvigencia_fin,
   @w_fecha_endozo     = po_fecha_endozo,
   @w_monto_endozo     = po_monto_endozo,
   @w_moneda           = po_moneda,
   @w_cobertura        = po_cobertura,
   @w_descripcion      = po_descripcion,
   @w_codigo_externo   = po_codigo_externo,
   @w_fendozo_fin      = po_fendozo_fin,
   @w_estado_poliza    = po_estado_poliza,
   @w_renovacion       = po_renovada,
   @w_cuenta	       = po_cuenta,
   @w_frenovacion      = po_frenovacion,
   @w_tipo_cta	       = po_tipo_cta,
   @w_monto_comision   = po_comision
   from cob_custodia..cu_poliza
   where 
   po_aseguradora = @i_aseguradora and
   po_poliza = @i_poliza and
   po_codigo_externo = @w_codigo_externo 

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end


/* CREACION TABLA TEMPORAL DE COTIZACION */

/*create table #cotizacion_moneda
       (moneda tinyint,
        cotizacion float null)*/

insert into cu_tmp_cotizacion_monedagar
(moneda, cotizacion,sesion)
select
a.cv_moneda, a.cv_valor,@w_pid_cus
from cob_conta..cb_vcotizacion a
where cv_fecha =(select max(b.cv_fecha)
                 from cob_conta..cb_vcotizacion b
                 where b.cv_moneda = a.cv_moneda
                 and b.cv_fecha <= @w_today)

--INSERTAR UN REGISTRO PARA LA MONEDA LOCAL
if not exists(select * from cu_tmp_cotizacion_monedagar
              where moneda = @w_def_moneda
              and sesion = @w_pid_cus)
insert into cu_tmp_cotizacion_monedagar (moneda, cotizacion,sesion)
values(@w_def_moneda,1,@w_pid_cus)


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'T'
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   select @w_porcentaje = pa_float -- PORCENTAJE POLIZA
    from cobis..cl_parametro
    where pa_producto = 'GAR'
    and pa_nemonico = 'PPO'
    set transaction isolation level read uncommitted

   select @w_valor_actual = isnull(cu_valor_inicial,0)*isnull(cotizacion,1)
     from cu_custodia,cu_tmp_cotizacion_monedagar        
    where cu_codigo_externo = @w_codigo_externo
      and moneda         = cu_moneda
      and sesion         = @w_pid_cus 
      /*and cv_fecha          = (select max(cv_fecha)
                                 from cob_conta..cb_vcotizacion,cu_custodia
                                where cv_fecha <=  @w_today
                                  and cv_moneda = cu_moneda
                                  and cu_codigo_externo = @w_codigo_externo)*/

   if  @w_valor_actual = 0
   begin
      /* Campos NOT NULL con valores nulos */
      select @w_error   = 1901017
      goto ERROR
   end
end


if @i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'T'
begin

   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   if @i_aseguradora is NULL or 
      @i_poliza is NULL or
      @w_codigo_externo is NULL
   begin
      /* Campos NOT NULL con valores nulos */
      select @w_error   = 1901001
      goto ERROR 
   end

   if @s_date <= @i_fvigencia_fin
   begin
      if @i_estado_poliza = 'VEN' 
 begin
        print 'Error el estado de la Poliza no puede ser vencido'
      end
   end

 
   if @i_monto_poliza <> 0
   begin

      select @w_porcentaje = pa_float -- PORCENTAJE POLIZA
        from cobis..cl_parametro
       where pa_producto = 'GAR'
         and pa_nemonico = 'PPO'
       set transaction isolation level read uncommitted

      select @w_valor_actual = isnull(cu_valor_inicial,0)*isnull(cotizacion,1)
        from cu_custodia,cu_tmp_cotizacion_monedagar
       where cu_codigo_externo = @w_codigo_externo
         and moneda           = cu_moneda 
         and sesion           = @w_pid_cus
         /*and cv_fecha            = (select max(cv_fecha)
                                    from cob_conta..cb_vcotizacion,cu_custodia
                                   where cv_fecha <= @w_today
                                     and cv_moneda = cu_moneda
                                     and cu_codigo_externo = @w_codigo_externo) */

      if @w_valor_actual = 0
      begin
         /* Campos NOT NULL con valores nulos */
         select @w_error   = 1901017
         goto ERROR
      end
   end
end


/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
   -- pga 11jun2001
   select @w_secservicio = @@spid

   begin tran

      exec sp_externo @i_filial,@i_sucursal, @i_tipo,@i_custodia,
                      @w_codigo_externo out


      if @w_existe = 1		--Si Existe
      begin
         update cob_custodia..cu_poliza
         set 
         po_fvigencia_inicio = @i_fvigencia_inicio,
         po_fvigencia_fin    = @i_fvigencia_fin,
         po_moneda           = @i_moneda,
         po_monto_poliza     = @i_monto_poliza,
         po_fecha_endozo     = @i_fecha_endozo,
         po_monto_endozo     = @i_monto_endozo,
         po_cobertura        = @i_cobertura,
         po_descripcion      = @i_descripcion,
         po_fendozo_fin      = @i_fendozo_fin,
         po_estado_poliza    = @i_estado_poliza,
         po_renovada	     = @i_renovacion,	--NVR-BE
         po_cuenta    	     = @i_cuenta,	--MVG-Bo
         po_tipo_cta  	     = @i_tipo_cta, 	--MVG-BE
         po_comision         = @i_monto_comision
         where 
         po_aseguradora = @i_aseguradora and
         po_poliza = @i_poliza and
         po_codigo_externo = @w_codigo_externo

         if @@error <> 0 
         begin
            /* Error en actualizacion de registro */
            select @w_error = 1905001
            goto ERROR
         end

         /* Transaccion de Servicio */
         /***************************/
         insert into ts_poliza
         values (@w_secservicio,@t_trn,'P',@s_date,
         @s_user,@s_term,@s_ofi,'cu_poliza',
         @w_aseguradora, @w_poliza, @w_fvigencia_inicio,
         @w_fvigencia_fin, @w_moneda, @w_monto_poliza,
         @w_fecha_endozo, @w_monto_endozo, @w_cobertura,
         @w_descripcion, @w_codigo_externo, @w_fendozo_fin,
         @w_renovacion, @w_cuenta, @w_tipo_cta,@w_monto_comision) 

         if @@error <> 0 
         begin
            /* Error en insercion de transaccion de servicio */
            select @w_error   = 1903003
            goto ERROR
         end


         /* Transaccion de Servicio */
         /***************************/
         insert into ts_poliza
         values (@w_secservicio,@t_trn,'A',
         @s_date,@s_user,@s_term,@s_ofi,'cu_poliza',
         @i_aseguradora, @i_poliza, @i_fvigencia_inicio,
         @i_fvigencia_fin, @i_moneda, @i_monto_poliza,
         @i_fecha_endozo, @i_monto_endozo, @i_cobertura,
         @i_descripcion, @w_codigo_externo, @i_fendozo_fin,
         @i_renovacion,	@i_cuenta, @i_tipo_cta,@i_monto_comision)
         if @@error <> 0 
         begin
            /* Error en insercion de transaccion de servicio */
               select @w_error   = 1903003
               goto ERROR
         end

end
   commit tran
   return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin

   if @w_existe = 1
   begin
      select @w_des_aseguradora = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla
         and B.tabla = "cu_des_aseguradora"
         and A.codigo = @w_aseguradora
       set transaction isolation level read uncommitted

      select @w_des_moneda = mo_descripcion
        from cobis..cl_moneda
       where mo_moneda = @w_moneda

      select @w_des_cobertura = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla 
         and B.tabla = "cu_cob_poliza" 
         and A.codigo = @w_cobertura
       set transaction isolation level read uncommitted

      select @w_des_estado_poliza = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla 
         and B.tabla = 'cu_estado_poliza' 
         and  A.codigo = @w_estado_poliza
      set transaction isolation level read uncommitted

      select 
      @w_aseguradora,
      @w_des_aseguradora,
      @w_poliza,
      convert(char(10),@w_fvigencia_inicio,@i_formato_fecha),
      convert(char(10),@w_fvigencia_fin,@i_formato_fecha),
      isnull(convert(varchar(25),@w_moneda),""),
      @w_des_moneda,
      @w_monto_poliza,
      convert(char(10),@w_fecha_endozo,@i_formato_fecha),
      @w_monto_endozo, 		 -- 10
      @w_cobertura,
      @w_des_cobertura,
      @w_descripcion,
      @w_codigo_externo,
      convert(char(10),@w_fendozo_fin,@i_formato_fecha),
      @w_estado_poliza,
      @w_des_estado_poliza,
      @w_renovacion,		
      @w_cuenta,
      @w_tipo_cta,
      @w_monto_comision 
   end
   else
      return 1 
   return 0
end

if @i_operacion = 'A'
begin
      set rowcount 20

      if (@i_aseguradora is null and @i_poliza is null)
         select @i_aseguradora = @i_param1,
                @i_poliza = @i_param2

      if @i_modo = 0 
      begin
         select
         "ASEGURADORA" = po_aseguradora,
         "POLIZA" = po_poliza,
         "MONTO" = po_monto_poliza
         from cu_poliza

         if @@rowcount = 0
         begin
            select @w_error   = 1901003
            goto ERROR
         end
      end
      else 
      begin
         select po_aseguradora, po_poliza, po_monto_poliza
           from cu_poliza
          where ((po_aseguradora > @i_aseguradora) or
                (po_poliza > @i_poliza and po_aseguradora = @i_aseguradora))

         if @@rowcount = 0
         begin
            select @w_error   = 1901004
            goto ERROR
         end
      end
end

if @i_operacion = 'S'
begin
   set rowcount 20

   if @i_modo = 0 
   begin
      select
      "ASEGURADORA" = po_aseguradora,
      "POLIZA" = po_poliza,
      "GARANTIA" = po_codigo_externo,
      "FECHA VENCIMIENTO" = po_fvigencia_inicio,
      "FECHA VIGENCIA" = po_fvigencia_fin, 
      "MONTO" = po_monto_poliza,
      "FECHA ENDOSO" = po_fecha_endozo
      from cu_poliza 
      if @@rowcount = 0
      begin
         select @w_error   = 1901003
         goto ERROR 
      end
   end
   else 
   begin
      select
      "ASEGURADORA" = po_aseguradora,
      "POLIZA" = po_poliza,
      "GARANTIA" = po_codigo_externo,
      "FECHA VENCIMIENTO" = po_fvigencia_inicio,
      "FECHA VIGENCIA" = po_fvigencia_fin, 
      "MONTO" = po_monto_poliza,
      "FECHA ENDOSO" = po_fecha_endozo
      from cu_poliza 
      where ((po_aseguradora > @i_aseguradora) or
            (po_poliza > @i_poliza and po_aseguradora = @i_aseguradora))
      if @@rowcount = 0
      begin
         select @w_error   = 1901004
         goto ERROR 
      end
   end
end

if @i_operacion = 'D'
begin

   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   if @w_existe=1
   begin
       delete cu_poliza
        where po_aseguradora    = @i_aseguradora
          and po_poliza         = @i_poliza
          and po_codigo_externo = @w_codigo_externo
   end
end


if @i_operacion = 'V'
begin
   set rowcount 20

   exec sp_externo
        @i_filial =     @i_filial,
        @i_sucursal =   @i_sucursal,
        @i_tipo =       @i_tipo,
        @i_custodia =   @i_custodia,
        @o_compuesto  = @w_codigo_externo out

      
   select 
   'ASEGURADORA' = po_aseguradora,
   'POLIZA'      = po_poliza,
   'CODIGO'      = po_codigo_externo
    from  cu_poliza
    where po_codigo_externo = @w_codigo_externo
    order by po_aseguradora,po_poliza
end

if @i_operacion = 'Z'
begin   
   -- Aumente esta parte MVI y en el and 
   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   if exists (select * from cu_poliza
               where po_aseguradora = @i_aseguradora
                 and po_poliza      = @i_poliza
                 and po_codigo_externo = @w_codigo_externo) --LAL DESCOMENTO
   begin
      select 
      @w_aseguradora = po_aseguradora,
      @w_poliza = po_poliza,
      @w_monto_poliza = po_monto_poliza,
      @w_fvigencia_inicio = po_fvigencia_inicio,
      @w_fvigencia_fin = po_fvigencia_fin,
      @w_fecha_endozo = po_fecha_endozo,
      @w_monto_endozo = po_monto_endozo,
      @w_moneda       = po_moneda,
      @w_cobertura    = po_cobertura,
      @w_descripcion  = po_descripcion,
      @w_codigo_externo = po_codigo_externo,
      @w_fendozo_fin    = po_fendozo_fin,
      @w_estado_poliza  = po_estado_poliza,
      @w_renovacion	= po_renovada,  	
      @w_cuenta         = po_cuenta,
      @w_tipo_cta       = po_tipo_cta,
      @w_monto_comision = po_comision
      from cob_custodia..cu_poliza
      where 
      po_aseguradora = @i_aseguradora and
      po_poliza = @i_poliza and
      po_codigo_externo = @w_codigo_externo   
      
      select @w_des_aseguradora = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla 
         and B.tabla  = "cu_des_aseguradora" 
         and A.codigo = @w_aseguradora
       set transaction isolation level read uncommitted

      select @w_des_moneda = mo_descripcion
        from cobis..cl_moneda
       where mo_moneda = @w_moneda

      select @w_des_cobertura = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla 
         and B.tabla = "cu_cob_poliza" 
         and A.codigo = @w_cobertura
       set transaction isolation level read uncommitted

      select @w_des_estado_poliza = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla 
         and B.tabla = "cu_estado_poliza" 
         and A.codigo = @w_estado_poliza
      set transaction isolation level read uncommitted

      select 
      @w_aseguradora,
      @w_des_aseguradora,
      @w_poliza,
      convert(char(10),@w_fvigencia_inicio,@i_formato_fecha),
      convert(char(10),@w_fvigencia_fin,@i_formato_fecha),
      isnull(convert(varchar(25),@w_moneda),""),
      @w_des_moneda,
      @w_monto_poliza,
      convert(char(10),@w_fecha_endozo,@i_formato_fecha),
      @w_monto_endozo,
      @w_cobertura,
      @w_des_cobertura,
      @w_descripcion,
      @w_codigo_externo,
      convert(char(10),@w_fendozo_fin,@i_formato_fecha),
      @w_estado_poliza,
      @w_des_estado_poliza,
      @w_renovacion,
      @w_cuenta,
      @w_tipo_cta,
      @w_monto_comision		
   end
   else
      return 1
end


/* RENOVACION DE POLIZAS */

if (@i_operacion = 'F')	
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   if @i_monto_endozo <> 0  
   begin tran
      select @w_delta = datediff(dd,isnull(@w_frenovacion,
                         @w_fvigencia_inicio),@w_fvigencia_fin)
      select @w_nn = convert(char(10),dateadd(dd,@w_delta, @s_date), 101)

      update cu_poliza
      set
      po_monto_poliza	      = @i_monto_poliza,
      po_fvigencia_fin	      = convert(char(10),dateadd(dd,@w_delta, @s_date), 101),
      po_frenovacion          = @s_date,
      po_renovada             = 'S', --@i_renovacion,
      po_monto_endozo         = @i_monto_endozo,
      po_comision             = @i_monto_comision
      where po_aseguradora  = @i_aseguradora
        and po_poliza       = @i_poliza
        and po_codigo_externo = @w_codigo_externo

      if @@rowcount <> 1
      begin
         select @w_error = 19050011
         goto ERROR
      end
   commit   tran
end

if (@i_operacion = 'E')
begin
   begin tran 
   if @@rowcount <> 1
   begin
      select @w_error = 1905001
      goto ERROR
   end
   commit   tran

end

if (@i_operacion = 'L')
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
   @w_codigo_externo out
   if @i_carga = 0
   begin
      begin
         if exists(select * from cu_poliza
                   where po_codigo_externo = @w_codigo_externo)
         begin
            begin tran
            /* XVE insert into cu_poliza_tmp(
            pt_aseguradora,pt_poliza,pt_fvigencia_inicio,
            pt_fvigencia_fin,pt_moneda,pt_monto_poliza,
            pt_fecha_endozo,pt_monto_endozo,pt_cobertura,
            pt_estado_poliza,pt_descripcion,pt_codigo_externo,
            pt_fendozo_fin,pt_renovacion,pt_renovada,
            pt_frenovacion,pt_cuenta,pt_tipo_cta)
            select
            po_aseguradora,po_poliza,po_fvigencia_inicio,
            po_fvigencia_fin,po_moneda,po_monto_poliza,
            po_fecha_endozo,po_monto_endozo,po_cobertura,
            po_estado_poliza,po_descripcion,po_codigo_externo,
            po_fendozo_fin,po_renovacion,po_renovada,
            po_frenovacion,po_cuenta,po_tipo_cta
            from  cu_poliza
            where  po_codigo_externo = @w_codigo_externo  */
            if @@error != 0
            begin
               print 'No se puede consultar las polizas'
               return 1
            end
            select @w_temporal = 1 
            commit tran
         end
         else
            select @w_temporal = 0
      end

      begin
         begin tran
        /* XVE  update cu_poliza_tmp
         set pt_sesion = @s_ssn
         where pt_codigo_externo = @w_codigo_externo*/
         if @@error != 0
         begin
            print 'No se puede consultar las polizas'
            return 1
         end
         commit tran
      end
   end
   if @i_carga = 1
   begin
      if @i_temporal = 1
      begin
         begin tran
         /* XVE delete cu_poliza_tmp
         where  pt_codigo_externo = @w_codigo_externo*/
         commit tran
      end
      else
      begin
         begin tran
         /* XVE update cu_poliza_tmp
         set pt_sesion = null
         where pt_codigo_externo = @w_codigo_externo*/
         commit tran
      end
   end
   select  @w_temporal

end

if (@i_operacion = 'T')
begin
  if @w_existe=0 --No existe
  begin  
      exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
      @w_codigo_externo out

      select @w_valor_comparativo = @i_monto_poliza/@w_valor_actual
      -- Si valor de la poliza supera el porcentaje de cobertura

      begin tran 
          /*if @w_valor_comparativo >= @w_porcentaje/100
          begin
             if exists (select por 
                         from cu_poliza
                        where po_codigo_externo = @w_codigo_externo)
             delete cu_poliza
              where po_codigo_externo = @w_codigo_externo*/
           
             insert into cu_poliza (              
	         po_aseguradora, po_poliza, po_fvigencia_inicio,
             po_fvigencia_fin, po_moneda, po_monto_poliza,
             po_fecha_endozo, po_monto_endozo, po_cobertura,
             po_descripcion, po_codigo_externo, po_fendozo_fin,
             po_estado_poliza, po_renovada, po_cuenta,  
             po_tipo_cta,po_comision)                    
             values (
             @i_aseguradora, @i_poliza, @i_fvigencia_inicio,
             @i_fvigencia_fin, @i_moneda, @i_monto_poliza,
             @i_fecha_endozo, @i_monto_endozo, @i_cobertura,
             @i_descripcion, @w_codigo_externo, @i_fendozo_fin,
             @i_estado_poliza, @i_renovacion, @i_cuenta, 
             @i_tipo_cta,@i_monto_comision)
             if @@error <> 0
             begin
                /* Error en insercion de registro */
                select @w_error   = 1903001
                goto ERROR
             end

             /*** CREAR CUENTA POR COBRAR EN CARTERA **/
             if @i_tipo_cta is not null
             begin  
		select @w_sector = 'C'
		select @w_toperacion = pa_char
		  from cobis..cl_parametro
		 where pa_producto = 'CCA'
	 	   and pa_nemonico = 'CCOB'
                set transaction isolation level read uncommitted

		return 0
             end 		--del tipo_cta
       commit tran
    end
    else
      print 'Poliza ya existe'
end
            
return 0
ERROR:    /* Rutina que dispara sp_cerror dado el codigo de error */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = @w_error
             return 1                                                                               
go

