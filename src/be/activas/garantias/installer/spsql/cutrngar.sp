/************************************************************************/
/*	Archivo: 	        constran.sp                             */
/*	Stored procedure:       sp_consulta_trans                       */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Anita Oleas*/
/*	Fecha de escritura:     May/14/98  				*/
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
/*				PROPOSITO			        */
/*	Manejo de transacciones por operacion.		                */
/*	T: Insercion de transaccion por operacion	                */
/*	U: Modificacion de transaccion por operacion	                */
/*	D: Eliminacion de transaccion por operacion	                */
/*	A: Consulta de transaccion por operacion	                */
/*	Q: Query de transaccion por operacion		                */
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA       AUTOR		 RAZON		                */
/*  	May/15/98   A.O                  Emision Inicial	        */
/************************************************************************/



use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_trn_gar')
    drop proc sp_trn_gar
go
create proc sp_trn_gar (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)   = null,
   @i_tgarantia          catalogo  = null,
   @i_tipo_trn           catalogo  = null,
   @i_tgarantia_b        catalogo  = null,
   @i_tipo_trn_b         catalogo  = null,
   @i_perfil             catalogo  = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tgarantia          catalogo,
   @w_tipo_trn           catalogo,
   @w_perfil             catalogo,
   @w_det_tgarantia      varchar(64),
   @w_det_tipotrn        varchar(64),
   @w_det_perfil         varchar(64),
   @w_error              int

--select @w_today = getdate()
select @w_today = @s_date
select @w_sp_name = 'sp_trn_gar'

if (@t_trn <> 19858 and @i_operacion = 'I') or
   (@t_trn <> 19859 and @i_operacion = 'D') or
   (@t_trn <> 19860 and @i_operacion = 'U') or
   (@t_trn <> 19861 and @i_operacion = 'Q') or
   (@t_trn <> 19861 and @i_operacion = 'S') or
   (@t_trn <> 19861 and @i_operacion = 'A') 
begin
   if @@error <> 0 begin
      select @w_error = 1901006
      goto ERROR
   end
end

/* Chequeo de Existencias */
if @i_operacion <> 'S' and @i_operacion <> 'A' begin

   select 
   @w_tipo_trn = trc_tran,
   @w_perfil = trc_perfil
   from cob_custodia..cu_tran_cust
   where
   trc_tran = @i_tipo_trn

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
if @i_operacion = 'I' or @i_operacion = 'U' 
begin
   if @i_tipo_trn is NULL
   begin
      select @w_error = 1901002
      goto ERROR
   end
end

/* INSERTAR */
if @i_operacion = 'I' begin
   if @w_existe = 1 begin
      select @w_error = 1901002
      goto ERROR
   end
   insert into cob_custodia..cu_tran_cust(
   trc_tran,   trc_perfil)
   values (
   @i_tipo_trn, @i_perfil)

   if @@error <> 0 begin
      select @w_error = 1901002
      goto ERROR
   end
end

/* ACTUALIZACION */
if @i_operacion = 'U' begin
   if @w_existe = 0 begin
      select @w_error = 1905002
      goto ERROR
   end
   update cob_custodia..cu_tran_cust set 
   trc_perfil = @i_perfil
   where 
   trc_tran = @i_tipo_trn
   if @@error <> 0 begin
      select @w_error = 1905001
      goto ERROR
   end
end


/* BORRADO */
if @i_operacion = 'D' begin
   if @w_existe = 0 begin
      select @w_error = 1907002
      goto ERROR
   end
   delete cob_custodia..cu_tran_cust
   where 
   trc_tran = @i_tipo_trn
   if @@error <> 0 begin
      select @w_error = 1907001
      goto ERROR
   end
end


/* BUSQUEDA DE REGISTRO */

if @i_operacion = "A" begin
   set rowcount 20 
   select 
   "Tipo Transaccion" = trc_tran,
   "Perfil" = trc_perfil
   from cob_custodia..cu_tran_cust
   where
   (trc_tran > @i_tipo_trn
   or @i_tipo_trn is null)
   and   (trc_tran = @i_tipo_trn_b or @i_tipo_trn_b is null)
   order by trc_tran

end 

/*  CONSULTA DE UN REGISTRO ESPECIFICO */
if @i_operacion = "Q" begin
   select 
   @w_tipo_trn = trc_tran,
   @w_perfil = trc_perfil
   from cob_custodia..cu_tran_cust
   where trc_tran = @i_tipo_trn
   and trc_perfil = @i_perfil


   select @w_det_tipotrn = Y.valor
   from cobis..cl_tabla X, cobis..cl_catalogo Y
   where X.tabla = "cu_tipo_tran"
   and Y.codigo = @w_tipo_trn
   and X.codigo = Y.tabla
   set transaction isolation level read uncommitted

   select @w_det_perfil = Y.valor
   from cobis..cl_tabla X, cobis..cl_catalogo Y
   where X.tabla = "cu_perfil"
   and Y.codigo = @w_perfil
   and X.codigo = Y.tabla
   set transaction isolation level read uncommitted

   select
          @w_tipo_trn,
          @w_det_tipotrn,
          @w_perfil,
          @w_det_perfil 
end     

return 0


ERROR:
exec cobis..sp_cerror
@t_debug = 'N',
@t_file  = null,
@t_from  = @w_sp_name,
@i_num   = @w_error
return @w_error

go