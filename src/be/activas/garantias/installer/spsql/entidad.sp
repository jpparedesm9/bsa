/************************************************************************/
/*      Archivo:                entidad.sp                              */
/*      Stored procedure:       sp_entidad                              */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Juan Carlos Espinosa                    */
/*      Fecha de escritura:     7/11/1998                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes  exclusivos  para el  Ecuador  de la   */
/*      "NCR CORPORATION".                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Insercion de bancos                                             */
/*      Modificacion de bancos                                          */
/*      Borrado de bancos                                               */
/*      Busqueda de bancos                                              */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                  RAZON                    */
/*      7/11/1998       Juan Carlos Espinosa   Emision Inicial          */
/*      09/11/2005      ElciraPelaez           Para DD                  */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_entidad')
   drop proc sp_entidad
go

create proc sp_entidad (
           @t_trn               smallint = null,
           @t_debug              char(1)  = 'N',
	   @t_file               varchar(14) = null,
	   @t_from               varchar(30) = null,
           @i_ultimo       	descripcion = null,
           @i_modo              tinyint = null,
           @i_tipo              char(1) = null,
           @i_banco             int = null,
           @i_operacion         char(1),
	   @i_cliente	  	  int = null,
	   @i_cliente_sig	  int = 0,
	   @i_num_negocio_sig   varchar(64) ='0',
	   @i_consulta		char(1) = null

)
as
declare @w_return       int,
	@w_sp_name      varchar(32)


select @w_sp_name = 'sp_entidad'

/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19901 and @i_operacion = 'H') or
   (@t_trn <> 19901 and @i_operacion = 'N')

begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = "H" 
begin
   if @i_tipo = "A"
   begin
      set rowcount 20
      if @i_modo = 0
         select  
        'Cod.'   = ba_banco,
        'Nombre' = convert(char(30),ba_descripcion)
         from cobis..cl_banco_rem 
         where ba_estado  = 'V'
        order by ba_descripcion
       else
       if @i_modo = 1
          select  
          'Cod.'  = ba_banco,
          'Nombre'= convert(char(30),ba_descripcion)
          from  cobis..cl_banco_rem
          where  ba_descripcion > @i_ultimo
          and    ba_estado      = 'V'
          order by ba_descripcion
    end


    if @i_tipo = "V"
    begin
       select convert(char(30),ba_descripcion)
       from cobis..cl_banco_rem
       where ba_banco = @i_banco
       and ba_estado = 'V'

       if @@rowcount = 0
       begin
          /* no existe dato solicitado */
          exec cobis..sp_cerror
          @t_from         = @w_sp_name,
          @i_num          = 101001
          return 1 
       end
    end
end



if @i_operacion = "N" 
begin
   set rowcount 20
   select distinct
	'CLIENTE' = do_proveedor,
	'NEGOCIO' = do_num_negocio
   from cu_documentos
   where 
	(do_proveedor = @i_cliente or @i_cliente is null)
   and ((do_proveedor = @i_cliente_sig and do_num_negocio > @i_num_negocio_sig)
       or (do_proveedor > @i_cliente_sig))
   and (do_estado = 'P' or @i_consulta = 'S')
   order by do_proveedor,
	do_num_negocio


end
return 0
go