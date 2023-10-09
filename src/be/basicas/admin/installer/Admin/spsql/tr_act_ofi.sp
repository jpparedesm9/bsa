/************************************************************************/
/*	Archivo: 		ccactofi.sp				*/
/*	Stored procedure: 	sp_tr_act_ofi                           */
/*	Base de datos:  	cobis				        */
/*	Producto:               Cuentas Corrientes			*/
/*	Disenado por:           Julio Navarrete   			*/
/*	Fecha de escritura:     13-Dic-1994				*/
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
/*	Este programa realiza la transaccion de actualizacion de        */
/*	oficiales de credito.                                           */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	5/Ene/1995      A. Villarreal   Emision inicial para Banco de   */
/*                                      la Produccion                   */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tr_act_ofi')
        drop proc sp_tr_act_ofi







go
create proc sp_tr_act_ofi (
	@s_ssn          int,
	@s_srv          varchar(30),
	@s_lsrv         varchar(30),
	@s_user         varchar(30),
	@s_sesn         int,
	@s_term         varchar(32),
	@s_date         datetime,
	@s_ofi          smallint,
	@s_rol          smallint = 1,
	@s_org_err      char(1)  = null,
	@s_error        int      = null,
	@s_sev          tinyint  = null,
	@s_msg          mensaje  = null,
	@s_org          char(1),
        @t_rty          char(1) = 'N',
        @t_from         char(1) = null,
	@t_debug	char(1) = 'N',
	@t_file		char(1) =  null,
	@t_trn		smallint,
	@i_oficial 	smallint,
        @i_funcio       smallint,
        @i_super        smallint,
	@i_nivel	varchar(3),
        @i_sector       catalogo
)
as
declare @w_sp_name	descripcion,
        @w_oficial      smallint,
        @v_oficial      smallint,
        @w_funcio       smallint, 
        @v_funcio       smallint,
        @w_super        smallint,
        @v_super        smallint,
        @w_sector       catalogo,
        @v_sector       catalogo,
        @w_nivel        varchar(3),
        @v_nivel        varchar(3),
	@w_maximo	smallint

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_act_ofi'

/*  Activacion del Modo de debug  */


/* Esta transaccion realiza la insercion de los datos del oficial de */
/* credito en la tabla cc_oficial                                    */

  /* Los Datos Anteriores */
  select @w_oficial = oc_oficial,
         @w_funcio  = oc_funcionario,
         @w_super   = oc_ofi_nsuperior,
         @w_nivel   = oc_tipo_oficial,
         @w_sector  = oc_sector
  from   cobis..cc_oficial
  where  oc_oficial = @i_oficial

  /* Si no existen datos anteriores */
  if @@rowcount = 0
  begin
     /* No existe oficial */
     exec cobis..sp_cerror
          @t_debug	= @t_debug,
          @t_file	= @t_file,
          @t_from	= @w_sp_name,
          @i_num	= 201116
     return 1
   end

  if exists (select * from cobis..cc_oficial
              where oc_funcionario = @i_funcio
                and oc_funcionario <> @w_funcio)
  begin
     /* El funcionario ya esta asignado a un oficial */
     exec cobis..sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_msg        = 'El funcionario ya esta asignado a un oficial ',
          @i_num        = 151076
     return 1
   end

  select @w_maximo = convert(smallint, max(oc_tipo_oficial))
    from cobis..cc_oficial
   where oc_ofi_nsuperior = @i_oficial

  if @w_maximo >= convert(smallint, @i_nivel)
  begin
     /* No puede ser cambiado el nivel de oficial a uno menor o igual */
     exec cobis..sp_cerror
          @t_debug	= @t_debug,
          @t_file	= @t_file,
          @t_from	= @w_sp_name,
          @i_num	= 201117
     return 1
   end

  /* Guardando el dato anterior y el actual */
  select @v_oficial = @w_oficial,
         @v_funcio  = @w_funcio,
         @v_super   = @w_super,
         @v_nivel   = @w_nivel,
         @v_sector  = @w_sector

  if @w_funcio  = @i_funcio
     select @w_funcio  = null,
            @v_funcio  = null
  else
     select @w_funcio  = @i_funcio

  if @w_super   = @i_super
     select @w_super   = null,
            @v_super   = null
  else
     select @w_super   = @i_super

  if @w_nivel   = @i_nivel
     select @w_nivel   = null,
            @v_nivel   = null
  else
     select @w_nivel   = @i_nivel

  if @w_sector  = @i_sector
     select @w_sector  = null,
            @v_sector  = null
  else
     select @w_sector  = @i_sector

begin tran

    /* Modificar con los nuevos datos */
    update cobis..cc_oficial
       set oc_funcionario   = @i_funcio,
           oc_ofi_nsuperior = @i_super,
           oc_tipo_oficial  = @i_nivel,
           oc_sector        = @i_sector
     where oc_oficial       = @i_oficial

    if @@rowcount != 1
      begin
        /* Error en actualizcion de oficial */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 205018
        return 1
      end

    /* Transaccion de Servicio datos anteriores */
    insert into cobis..cc_tsoficial
             (secuencia, tipo_transaccion, clase, tsfecha,
              usuario, terminal, oficina,reentry,
              origen, oficial, funcionario,
              ofi_superior, nivel, sector
             )
    values   (@s_ssn, @t_trn, 'P', @s_date,
              @s_user, @s_term, @s_ofi, @t_rty,
              @s_org, @i_oficial, @v_funcio,
              @v_super, @v_nivel, @v_sector
             )

    if @@rowcount != 1
      begin
        /* Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 203005
        return 1
      end

    /* Transaccion de Servicio datos nuevos */
    insert into cobis..cc_tsoficial
             (secuencia, tipo_transaccion, clase, tsfecha,
              usuario, terminal, oficina,reentry,
              origen, oficial, funcionario,
              ofi_superior, nivel, sector
             )
    values   (@s_ssn, @t_trn, 'A', @s_date,
              @s_user, @s_term, @s_ofi, @t_rty,
              @s_org, @i_oficial, @w_funcio,
              @w_super, @w_nivel, @w_sector
             )

    if @@rowcount != 1
      begin
        /* Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 203005
        return 1
      end
 
commit tran

return 0
go
