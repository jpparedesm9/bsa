/*****************************************************************************/
/*  ARCHIVO:         valor_gmf.sp                                            */
/*  NOMBRE LOGICO:   sp_valor_gmf                                            */
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
/*                              PROPOSITO                                    */
/* Actualiza la tabla de movimientos monetarios con el valor del Gravamen    */
/* a los movimientos financieros y devuelve el valor todal de calculado      */
/* para la transaccion.                                                      */
/*                                                                           */
/*                              MODIFICACIONES                               */
/*      FECHA      AUTOR              RAZON                                  */
/*      Sep-23-09  Monica Vidal       Rediseño                               */
/*      Dic-05-16  A.Zuluaga          Desacople                              */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_valor_gmf') is not null
   drop proc sp_valor_gmf
go

create proc sp_valor_gmf
@t_trn                  int        = 0,
@s_date                 datetime   = null,
@i_tran                 int,
@i_operacionpf          int,
@i_secuencia            int,
@o_valor_iee            money      = null out
with encryption
as
declare
@w_tabla_iee            int,
@w_impto_ee             float,
@w_numdeci              tinyint,
@w_cuenta               cuenta, --DFNIETOP REQ 329
@w_cuenta_ah            cuenta, --DFNIETOP REQ 329
@w_op_ente              int,    --DFNIETOP REQ 329
@w_ah_cliente           int,    --DFNIETOP REQ 329
@w_num_tit              int,     --DFNIETOP REQ 329
@w_sub_secuencia        int,
@w_producto             varchar(10),
@w_cobra_gmf            char(1),
@w_cobra_tmp            char(1),
@w_count_benef_papa     int,
@w_cuenta_cobis         cuenta,
@w_cliente              int,
@w_error                int

/* TASA DEL IMPUESTO */
select @w_impto_ee =  pa_float
from   cobis..cl_parametro
where  pa_nemonico  = 'IMDB'
and    pa_producto  = 'PFI'

/* NUMERO DE DECIMALES */
select @w_numdeci = isnull (pa_tinyint,0)
from cobis..cl_parametro
where pa_nemonico = 'DCI'
and   pa_producto = 'PFI'

/* TABLA DE CONCEPTOS A LOS QUE SE COBRA EL IMPUESTO */
select @w_tabla_iee = codigo
from   cobis..cl_tabla
where  tabla = 'pf_fpagcob_ImpEmerEco'

select @w_sub_secuencia = 0
   
while 1=1
begin
   set rowcount 1
      
   if @t_trn <> 14943 begin

		if  @i_tran = 14905 begin --  Solo debe hacerse un solo cobro

			update pf_mov_monet set
			mm_emerg_eco = round((isnull(mm_valor,0) * @w_impto_ee ), @w_numdeci)
			where  mm_operacion         = @i_operacionpf
			and    mm_tran              = @i_tran
			and    mm_estado            = 'A'
			and    mm_tipo              = 'C'
			and    mm_fecha_aplicacion  = @s_date
			and    mm_producto         in (  select   codigo
									   from cobis..cl_catalogo
									   where tabla = @w_tabla_iee)
			and   mm_secuencia      = @i_secuencia

			if @@error <> 0 
				return 145020

			goto CONS_FINAL

		end   

	   select @w_cuenta = mm_cuenta, @w_sub_secuencia = mm_sub_secuencia, @w_producto = mm_producto
	   from cob_pfijo..pf_mov_monet
	   where mm_operacion = @i_operacionpf
	   and mm_tran = @i_tran 
	   and mm_estado = 'A'
	   and mm_tipo = 'C'
	   and mm_producto not in ('EFEC','VXP') 
	   and mm_fecha_aplicacion = @s_date
	   and mm_producto in (select codigo from cobis..cl_catalogo where tabla = @w_tabla_iee)
	   and mm_secuencia = @i_secuencia
	   and mm_sub_secuencia > @w_sub_secuencia
	   order by mm_secuencia, mm_sub_secuencia
	   
	  if @@rowcount = 0
		 break    
   end
   else 
   begin 

		if  @t_trn = 14943 and @i_tran = 14905 begin -- No debe haber cobro
				goto CONS_FINAL
		end   
  
   	   select @w_cuenta = mm_cuenta, @w_sub_secuencia = mm_sub_secuencia, @w_producto = mm_producto
	   from cob_pfijo..pf_mov_monet
	   where mm_operacion = @i_operacionpf
	   and mm_tran = @t_trn 
	   and mm_estado = 'A'
	   and mm_tipo = 'C'
	   and mm_fecha_aplicacion = @s_date
	   and mm_producto in (select codigo from cobis..cl_catalogo where tabla = @w_tabla_iee)
	   and mm_secuencia = @i_secuencia
	   and mm_sub_secuencia > @w_sub_secuencia 
	   order by mm_secuencia, mm_sub_secuencia

	  if @@rowcount = 0
		 break   

	  select @i_tran = @t_trn	 
	end
   
   set rowcount 0

   select @w_op_ente = op_ente 
   from cob_pfijo..pf_operacion 
   where op_operacion = @i_operacionpf
   
   select @w_num_tit = 0
   select @w_cobra_gmf = 'S'

   if @w_producto = 'AHO' begin --Validaciones si es cuenta de ahorro

      exec @w_error = cob_interfase..sp_iahorros
           @i_operacion    = 'A',
           @i_cuenta_banco = @w_cuenta,
           @i_cliente      = @w_op_ente,
           @o_cuenta_ah    = @w_cuenta_cobis out,
           @o_cliente      = @w_cliente      out

      if @w_cuenta_cobis <> ''
      begin 

        /* CUENTA CON MAS DE UN TITULAR */
        select @w_cuenta_ah = dp_cuenta, @w_num_tit = count (1)
        from cobis..cl_cliente, cobis..cl_det_producto
        where cl_det_producto = dp_det_producto
        and cl_rol in ('T','C') --T=Titular / C=Cotitular ('T','C')
        and dp_producto   = 4
        and dp_estado_ser = 'V'
        and dp_cuenta     = @w_cuenta_cobis
        group by dp_cuenta

        /* CAPTURA DEL CLIENTE PARA LA CUENTA */
        select @w_ah_cliente = @w_cliente
     
        if exists (select 1 from cob_pfijo..pf_fpago where fp_mnemonico = 'AHO' and fp_exonera_gmf = 'S')
           select @w_cobra_tmp = 'N'
     
        if @w_ah_cliente =  @w_op_ente and @w_num_tit = 1 and @w_producto = 'AHO' and @w_cobra_tmp = 'N' -- NO COBRO DE GMF
           select @w_cobra_gmf = 'N'
      end
   end  --Fin AHO
       
    select	@w_count_benef_papa = isnull(count(1),0)
    	from	cob_pfijo..pf_beneficiario
    	where	be_operacion = @i_operacionpf
    	and		be_rol in( 'T','A')
    	and		be_tipo in ('T')
    	and		be_estado = 'I'
    	and		be_estado_xren = 'N'
     
   if @w_count_benef_papa <> 1
       select @w_cobra_gmf = 'S'       

           
   if  @w_cobra_gmf = 'S' begin
      /* ACTUALIZO LOS MOVIMIENTOS MONETARIOS A LOS QUE CORRESPONDE EL COBRO DE GMF */
      update pf_mov_monet set
      mm_emerg_eco = round((isnull(mm_valor,0) * @w_impto_ee ), @w_numdeci)
      where mm_operacion = @i_operacionpf
      and mm_tran = @i_tran
      and mm_tipo = 'C'
      and mm_fecha_aplicacion = @s_date
      and mm_producto in (select codigo from cobis..cl_catalogo where tabla = @w_tabla_iee)
      and mm_secuencia = @i_secuencia
      and mm_sub_secuencia = @w_sub_secuencia
      
      if @@error <> 0 return 145020
          
   end  --Fin Cobra GMF
 end --fin while      
      
CONS_FINAL:

  /* CONSOLIDO PARA INGRESAR COMO RUBRO EN EL DETALLE DE TRANSACCIONES A CONTABILIZAR */
  select @o_valor_iee = sum(mm_emerg_eco)
  from pf_mov_monet
  where mm_operacion = @i_operacionpf
  and mm_tran = @i_tran
  and mm_tipo = 'C'
  and mm_fecha_aplicacion = @s_date
  and mm_producto in ( select codigo from cobis..cl_catalogo where tabla = @w_tabla_iee)
  and mm_secuencia = @i_secuencia

return 0
go