/************************************************************************/
/*	Archivo: 	        dat_insp.sp                             */
/*	Stored procedure:       sp_dat_insp                             */
/*	Base de datos:  	cobis					*/
/*	Producto:               garantias               		*/
/*				Nydia Velasco Ramirez                   */
/*	Fecha de escritura:     Diciembre-1997 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta (Q) de datos de inspector del modulo MIS               */
/*	utiliza la tabla cl_ente,cl_direccion,cl_telefono               */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*									*/
/*	Dic/1997  Nydia Velasco       Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_dat_insp')
    drop proc sp_dat_insp
go
create proc sp_dat_insp (
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
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_inspector          int  = null,
   @i_nombre             descripcion  = null,
   @i_direccion          descripcion  = null,
   @i_telefono           varchar( 20)  = null,
   @i_cargo              descripcion  = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_inspector          int,
   @w_nombre             descripcion,
   @w_cedula             varchar(20),
   @w_direccion          descripcion,
   @w_cod_direccion      smallint,
   @w_telefono           varchar(20),
   @w_rep_legal		 int,
   @w_nom_rep_legal      descripcion

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_dat_insp'

/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19850 and @i_operacion = 'Q')

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
begin
    select 
         @w_nombre =cg_nombre,
         @w_cedula = en_ced_ruc,
         @w_cod_direccion = en_direccion
    from cobis..cl_ente, cu_cliente_garantia
    where 
         en_ente = @i_inspector

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* TRAER LOS DATOS DEL MIS */
/******************************/
if @i_operacion = 'Q'
begin
    if @w_existe = 1
    begin
  

         select @w_direccion = di_descripcion
           from cobis..cl_direccion
          where di_ente      = @i_inspector
            and di_direccion = convert(tinyint,@w_cod_direccion)
	  set transaction isolation level read uncommitted

	select @w_telefono  = te_valor
	from   cobis..cl_telefono 
	where  te_ente      = @i_inspector
	and    te_direccion = convert(tinyint,@w_cod_direccion)
	set transaction isolation level read uncommitted

	/*Representante Legal NVR-BE****/
	
	select @w_rep_legal = in_ente_d
	from cobis..cl_instancia
	where in_relacion = 205
	and   in_ente_i   = @i_inspector
	set transaction isolation level read uncommitted

	select @w_nom_rep_legal=cg_nombre
	from cobis..cl_ente, cu_cliente_garantia
	where en_ente = @w_rep_legal

	/*********************************/


         select
              @w_nombre,
              @w_cedula,
              @w_direccion,
              @w_telefono,
  	      @w_nom_rep_legal 	

         return 0
    end
    else
    /*begin
    Registro no existe 
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901005*/
    return 1 
end

go