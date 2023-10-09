/************************************************************************/
/*      Archivo:                elimreno.sp                             */
/*      Stored procedure:       sp_elimina_renovacion                   */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las transacciones de   */
/*      adicion, modificacion, eliminacion, search y query de las       */
/*      operaciones de plazos fijos.                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      01-Dic-94  Juan Lam           Creacion                          */
/*      05-Sep-95  Carolina Alvarado  XXXXXXXXX                         */
/*      19-Sep-95  Erika Sanchez B.   XXXXXXXXX                         */
/* 	21-08-2001 Memito Saborio     Se borra las instrucciones en la  */
/*                              tabla de instrucciones de la operacion. */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_elimina_renovacion' and type = 'P')
   drop proc sp_elimina_renovacion
go
create proc sp_elimina_renovacion (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int        = NULL,
@i_num_banco            cuenta)
with encryption
as
declare 
@w_sp_name              descripcion,
@w_string               varchar(30),
@w_descripcion          descripcion,
@w_return               int,
@w_secuencial           int,
@w_error                int,
@w_numdeci              tinyint,
@w_usadeci              char(1),
/** VARIABLES PARA PF_TRAN_REG **/
@w_tran_ren             int,
/** VARIABLES PARA PF_OPERACION **/
@w_num_banco            cuenta,
@w_ssn_spread           int,
@w_operacionpf          int,
@w_producto             tinyint, 
@w_toperacion           catalogo, 
@w_tplazo               catalogo,
@w_moneda               tinyint,
@w_oficina              smallint,     -- GAL 31/AGO/2009 - RVVUNICA
@w_historia             smallint,
@w_ofi_ing              int,
@w_estado		catalogo,
@w_valor		money,
@w_accion_sgte		catalogo,
@w_fecha                datetime,
@w_fecha_mod            datetime,
@w_renovacion           int,
@w_total_int_acumulado	money,
@w_total_int_ganados	money,
@v_num_banco            cuenta,
@v_operacionpf          int,
@v_historia             smallint,
@v_estado		catalogo,
@v_fecha_mod            datetime,
@v_accion_sgte		catalogo,
@w_incremento		money,
@v_total_int_ganados	money,
@v_total_int_acumulado	money

select @w_sp_name 	= 'sp_elimina_renovacion',
	@w_tran_ren 	= 14904,
	@w_ofi_ing 	= @s_ofi

/**  VERIFICAR CODIGO DE TRANSACCION **/
if @t_trn <> 14909
  begin
    exec cobis..sp_cerror 
	@t_debug=@t_debug,
	@t_file=@t_file,
	@t_from=@w_sp_name,   
	@i_num = 141018
    return 1
  end

/** SECCION DE LECTURA DE PF_OPERACION **/
select @w_operacionpf   = op_operacion,       
       @w_producto      = op_producto, 
       @w_tplazo        = op_tipo_plazo,
       @w_toperacion    = op_toperacion, 
       @w_moneda        = op_moneda ,
       @w_oficina       = op_oficina, 
       @w_historia	= op_historia,
       @w_accion_sgte   = op_accion_sgte,
       @w_fecha_mod 	= op_fecha_mod,
       @w_estado	= op_estado,
       @w_total_int_acumulado	= op_total_int_acumulado,
       @w_total_int_ganados	= op_total_int_ganados
from pf_operacion 
where op_num_banco = @i_num_banco 
and op_estado = 'ACT'
and op_accion_sgte = 'XREN'
if @@rowcount = 0
  begin
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         @t_from=@w_sp_name,   @i_num = 141004
    return 1
  end

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
        select @w_numdeci = isnull (pa_tinyint,0)
        from cobis..cl_parametro
        where pa_nemonico = 'DCI'
          and pa_producto = 'PFI'
end
else
        select @w_numdeci = 0   

/**  AJUSTE E INICIALIZACION DE VARIABLES  **/


select @v_historia    = @w_historia,
       @v_fecha_mod   = @w_fecha_mod,
       @w_historia    = @w_historia + 1,
       @v_accion_sgte = @w_accion_sgte,
       @v_total_int_ganados = @w_total_int_ganados,
       @w_total_int_ganados = @w_total_int_ganados+ @w_total_int_acumulado,
       @w_accion_sgte = 'NULL'

/* Obtengo el valor y secuencia para la eliminacion */
select @w_valor 	= re_monto + re_incremento,
       @w_renovacion 	= re_renovacion,
       @w_incremento    = re_incremento
	from pf_renovacion
where re_operacion = @w_operacionpf and
re_estado = 'I' 
if @@rowcount = 0
  begin
    exec cobis..sp_cerror 
	 @t_debug=@t_debug,
	 @t_file =@t_file,
         @t_from =@w_sp_name,   
	 @i_num  = 141138
    return 1
  end

begin tran

/*Eliminacion de tasas definidas en instruccion */
  delete from pf_rubro_op_i
  where roi_operacion = @w_operacionpf
  if @@error <> 0
    begin
      exec cobis..sp_cerror 
	@t_debug=@t_debug,
	@t_file=@t_file,
        @t_from=@w_sp_name, 
        @i_msg = 'Error en eliminacion de tasa variable operacion',
        @i_num = 145020
      return 1
    end

/** ACTUALIZACION DE MOV_MONET **/
  update pf_mov_monet 
     set mm_estado = 'E',
         mm_usuario = @s_user
    where mm_tran      = @w_tran_ren
      and mm_operacion = @w_operacionpf	
      --and mm_secuencia = @w_renovacion   
      and mm_secuencial = @w_renovacion 
      and mm_estado    is null
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145020
      return 1
    end

if @w_incremento > 0
begin
	/** CONTABILIZACION DE LA OPERACION **/
	 update pf_relacion_comp set rc_estado = 'R'
		where rc_num_banco = @i_num_banco and
		      rc_tran      = 'INC' and
		      rc_estado	   = 'N' 

	 update pf_scomprobante set sc_estado = 'R'
	   from pf_relacion_comp 
	 where  sc_comprobante = rc_comp and
	 	sc_estado = 'I' and
		rc_estado = 'R' and
		rc_tran = 'INC' and
		rc_num_banco = @i_num_banco
         if @@error  <> 0
         begin
           exec cobis..sp_cerror
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @w_sp_name,
                     @i_num           = 143041
           return 1
         end


end

/** ACTUALIZACION DE RENOVACION **/
  update pf_renovacion 
	set re_estado = 'E'
    where re_operacion = @w_operacionpf
      and re_renovacion= @w_renovacion

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145004
      return 1
    end

/** ACTUALIZACION BENEFICIARIO **/
   update pf_beneficiario set be_estado = 'E'   /*ERIKA se pone E en vez de I */
    where be_operacion = @w_operacionpf
      and be_estado_xren = 'S'
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145009
      return 1
    end


/** ACTUALIZACION DE DET_PAGO  **/
  update pf_det_pago 
     set dp_estado       = 'E'   /*ERIKA se pone E en vez de I */
    where dp_operacion   = @w_operacionpf
      and dp_estado_xren = 'S'
      and dp_estado      = 'I'
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145037
      return 1
    end

/*************************************
CCR Actualizacion de Spread a Anulado
*************************************/

if exists(	select 1 from pf_aut_spread
		where	as_estado	= 'U'
		and	as_operacion	= @w_operacionpf
		and	as_fecha	in (select max(as_fecha)
					from cob_pfijo..pf_aut_spread
					where as_operacion = @w_operacionpf
					and as_estado = 'U')
	)
begin
	update pf_aut_spread
	set	as_estado	= 'A',
		@w_ssn_spread   = as_secuencial
	where	as_estado	= 'U'
		and	as_operacion	= @w_operacionpf
		and	as_fecha	in (select max(as_fecha)
					from cob_pfijo..pf_aut_spread
					where as_operacion = @w_operacionpf
					and as_estado = 'U')
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debub	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 141187
		return 141187
	end

	delete from pf_autorizacion 
	where au_operacion = @w_operacionpf 
	and au_secuencial = @w_ssn_spread                                         
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debub	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 141187
		return 141187
	end


end
/***FIN CCR Act spread****************/

/****************************************
CCR Actualizacion de movimiento monetario
****************************************/
if exists (	select 1 from pf_mov_monet
		where	mm_estado	is null
		and	mm_tran		= 14904
		and	mm_operacion	= @w_operacionpf
	)
begin
	update pf_mov_monet
	set	mm_estado	= 'R'
	where	mm_estado	is null
	and	mm_tran		= 14904
	and	mm_operacion	= @w_operacionpf
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 145055
		return 145055
	end
end
/*******FIN CCR Act. Mov Monet***********/

/****************************************
CCR Actualizacion de instruccion especial
****************************************/
if exists	(select 1 from pf_instruccion
			where	isnull(in_estadoxren, 'N')	= 'S'
			and	in_operacion			= @w_operacionpf
		)
begin
	update pf_instruccion
	set	in_estadoxren	= 'E',
		in_fecha_mod	= @s_date
	where	in_estadoxren	= 'S'
	and	in_operacion	= @w_operacionpf
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 145056
		return 145056
	end
end
/****CCR FIN ACT INSTR. ESP.************/

/** ACTUALIZACION DE LA OPERACION **/
  update pf_operacion set 
      op_accion_sgte  = @w_accion_sgte,   /*ERIKA,se actualiza la accion sgte*/
      op_historia     = @w_historia,
      op_fecha_mod    = @s_date,
      op_total_int_ganados = isnull(round(@w_total_int_ganados,@w_numdeci),0)
  where op_operacion = @w_operacionpf
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145001
      return 1
    end

/** INSERCION DEL HISTORIAL **/
  insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
         hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
         hi_fecha_crea, hi_fecha_mod) 
              values (@w_operacionpf, @v_historia,@s_date,
         @t_trn,@w_valor, @s_user, @s_ofi,
         @s_date,@s_date)
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143006
      return 1
    end


     /** INSERCION DE LAS TRANSACCIONES DE TODAS LAS TABLAS MODIFICADAS **/

     /** INSERCION DE LAS TRANSACCIONES DE LA TABLA OPERACION **/

/** INSERCION DE TRANSACCION DE SERVICIO PREVIA **/
  insert ts_operacion (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, fecha, num_banco, 
       operacion, historia, accion_sgte, total_int_ganados, fecha_mod)
               values (@s_ssn, @t_trn,'P',
       @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco,
       @w_operacionpf,@v_historia,@v_accion_sgte,@v_total_int_ganados, @v_fecha_mod)
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      return 1
    end

/** INSERCION DE TRANSACCION DE SERVICIO ACTUALIZACION **/
  insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco, 
     operacion, historia, accion_sgte, total_int_ganados, fecha_mod)
             values (@s_ssn, @t_trn,'A',
     @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco,
     @w_operacionpf,@w_historia,@w_accion_sgte,@w_total_int_ganados, @s_date)
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      return 1
    end

     /** INSERCION DE LAS TRANSACCIONES DE LA TABLA RENOVACION **/

/** INSERCION DE TRANSACCION DE SERVICIO PREVIA **/
  insert ts_renovacion (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, fecha,  
       operacion, estado, fecha_mod)
               values (@s_ssn, @t_trn,'P',
       @s_user, @s_term, @s_srv, @s_lsrv, @s_date, 
       @w_operacionpf, 'I', @v_fecha_mod)
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      return 1
    end

/** INSERCION DE TRANSACCION DE SERVICIO ACTUALIZACION **/
  insert ts_operacion (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, fecha,
       operacion, estado, fecha_mod)
               values (@s_ssn, @t_trn,'A',
       @s_user, @s_term, @s_srv, @s_lsrv, @s_date, 
       @w_operacionpf, 'E',@s_date)
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      return 1
    end

/** INSERCION DE TRANSACCION DE SERVICIO **/
  insert ts_historia (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, 
       operacion, secuencia2, fecha, fecha_crea,
       fecha_mod, transaccion, valor, funcionario, oficina)
               values (@s_ssn, @t_trn,'N',
       @s_user, @s_term, @s_srv, @s_lsrv,
       @w_operacionpf,@w_historia, @s_date, @s_date,
       @s_date,@t_trn, 0, @s_user, @s_ofi)
  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      return 1
    end

  /** En caso de existir renovación de instrucciones se debe de borrar ***/
  /** Se borra las instrucciones en la tabla de instrucciones de la operación ***
   ** JSA >>>>>>>> 21-ago-2001, segun DP-000073                               ***/
  if exists (select * from pf_instruccion 
    	       where in_operacion = @w_operacionpf 
    	         and in_estadoxren = 'S') 
  begin 
    delete pf_instruccion
    where in_operacion = @w_operacionpf 
      and in_estadoxren = 'S'    
    if @@error <> 0 
    begin
      exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
           @t_from  = @w_sp_name, @i_num   = 147044
      return 1
    end
    
    insert into ts_instruccion (secuencial, tipo_transaccion,clase,fecha,
        usuario,terminal,srv,lsrv, operacion,instruccion)
    values  (@s_ssn, 14238, 'N', @s_date, @s_user, @s_term,
        @s_srv,@s_lsrv,@w_operacionpf,'E - Eliminacion instruccion de renovacion')
    /* Si no se puede insertar error */
    if @@error <> 0 
    begin
      exec cobis..sp_cerror
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num         = 143005
      return 1
    end   
  end /*** revision de que no sea null ***/
  /****** Fin de cambio DP-000073 realizado por memito ***********/


-------------------------------------------------------
-- Borrar registros ingresados de pf_secuen_ticket (I)
-------------------------------------------------------
delete pf_secuen_ticket
 where st_estado = 'I'
   and st_operacion = @w_operacionpf

commit tran 
return 0
go

