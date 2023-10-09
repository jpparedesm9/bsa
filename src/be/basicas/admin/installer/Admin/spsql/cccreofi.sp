/************************************************************************/
/*	Archivo: 		cccreofi.sp				*/
/*	Stored procedure: 	sp_tr_crea_ofi                          */
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
/*	Este programa realiza la transaccion de creacion de oficiales   */
/*	de credito.                                                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	13/Dic/1994     J. Bucheli	Emision inicial para Banco de   */
/*                                      la Produccion                   */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tr_crea_ofi')
        drop proc sp_tr_crea_ofi








go
create proc sp_tr_crea_ofi (
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
        @i_funcio       smallint,
        @i_super        smallint,
	@i_nivel	varchar(3),
        @i_sector       catalogo
)
as
declare @w_sp_name	descripcion

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_crea_ofi'

/*  Activacion del Modo de debug  */


/* Esta transaccion realiza la insercion de los datos del oficial de */
/* credito en la tabla cc_oficial                                    */

select oc_funcionario
  from cobis..cc_oficial
 where oc_funcionario = @i_funcio

 if @@rowcount <>  0
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

begin tran

  insert into  cobis..cc_oficial 
               (oc_oficial, oc_funcionario, oc_ofi_nsuperior,
                oc_tipo_oficial, oc_sector)
       values  (@i_oficial, @i_funcio, @i_super,
                @i_nivel, @i_sector)

  if @@error != 0
    begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
           @t_debug	 = @t_debug,
           @t_file	 = @t_file,
           @t_from	 = @w_sp_name,
           @i_num	 = 203019
      return 1
    end
 
  /* Grabacion de Transaccion de Servicio */

  insert into cobis..cc_tsoficial
              (secuencia, tipo_transaccion, clase, tsfecha,
               usuario, terminal, oficina, reentry,
               origen, oficial, funcionario,
               ofi_superior, nivel, sector
              )
  values     (@s_ssn, @t_trn, 'N', @s_date,
              @s_user, @s_term, @s_ofi, @t_rty,
              @s_org, @i_oficial, @i_funcio,
              @i_super, @i_nivel, @i_sector
             )

  if @@error != 0
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
