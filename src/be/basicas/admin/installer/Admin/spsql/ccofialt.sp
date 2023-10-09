/************************************************************************/
/*	Archivo: 		ccofialt.sp				*/
/*	Stored procedure: 	sp_tr_ofi_alt                           */
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
/*	11/Ene/1995     A. Villarreal   Emision inicial para Banco de   */
/*                                      la Produccion                   */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tr_ofi_alt')
        drop proc sp_tr_ofi_alt







go
create proc sp_tr_ofi_alt (
	@s_ssn          int,
	@s_srv          varchar(30),
	@s_lsrv         varchar(30),
	@s_user         varchar(30),
	@s_sesn         int,
	@s_term         varchar(10),
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
        @i_sustit       smallint = null
)
as
declare @w_sp_name	descripcion,
        @w_sustit       smallint, 
        @v_sustit       smallint

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_ofi_alt'

/*  Activacion del Modo de debug  */


/* Esta transaccion realiza la actualizacion del oficial alterno de */
/* credito en la tabla cc_oficial                                    */

  if @i_sustit <= 0
     select @i_sustit = null

  /* Los Datos Anteriores */
  select @w_sustit  = oc_ofi_sustituto
    from cobis..cc_oficial
   where oc_oficial = @i_oficial

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

  /* Guardando el dato anterior y el actual */
  select @v_sustit  = @w_sustit

  if @w_sustit  = @i_sustit
     select @w_sustit  = null,
            @v_sustit  = null
  else
     select @w_sustit  = @i_sustit

begin tran

    /* Modificar con los nuevos datos */
    update cobis..cc_oficial
       set oc_ofi_sustituto = @i_sustit
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
              usuario, terminal, oficina, reentry,
              origen, oficial, ofi_sustituto
             )
    values   (@s_ssn, @t_trn, 'P', @s_date,
              @s_user, @s_term, @s_ofi, @t_rty,
              @s_org, @i_oficial, @v_sustit
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
              origen, oficial, ofi_sustituto
             )
    values   (@s_ssn, @t_trn, 'A', @s_date,
              @s_user, @s_term, @s_ofi, @t_rty,
              @s_org, @i_oficial, @w_sustit
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
