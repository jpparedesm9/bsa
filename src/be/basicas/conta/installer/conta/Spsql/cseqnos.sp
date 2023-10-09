/************************************************************************/
/*	Archivo: 		cseqnos.sp				*/
/*	Stored procedure: 	sp_cseqnos				*/
/*	Base de datos:  	cb_conta					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de documentacion:	17/Nov/93				*/
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
/*      Retornar un nuevo secuencial para la tabla pasada como          */
/*      parametro.                                                      */
/*      Notas: las tablas se inicializan con secuencial cero            */
/*             mensaje de error si secuencial llega a 2147483647        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      17/Nov/93       R. Minga V.     Documentacion                   */
/*	04/May/94	F.Espinosa	Parametros tipo "S"		*/
/*	14/Mar/95	M.Suarez  	Debe comsiderar empresa en      */
/*                                      secuencias.                     */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cseqnos')
	drop proc sp_cseqnos
go

create proc sp_cseqnos (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@i_tabla 	        varchar(30), 
        @i_empresa              tinyint=null,
        @i_pkey              varchar(30)=null,
        @i_operacion            char(1)=null,
	@o_siguiente 		int=null out
	)
as
declare @w_return       int,
        @w_sp_name      varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cseqnos'


/*  Modo de debug  */
if @t_debug = 'S'
begin
        exec cobis..sp_begin_debug @t_file = @t_file
        select  '/**  Stored Procedure  **/ ' = @w_sp_name,
		s_ssn			   = @s_ssn,
		s_user			   = @s_user,
		s_sesn			   = @s_sesn,
		s_term			   = @s_term,	
		s_date			   = @s_date,	
		s_srv			   = @s_srv,	
		s_lsrv			   = @s_lsrv,	
		s_rol			   = @s_rol,
		s_ofi			   = @s_ofi,
		s_org_err		   = @s_org_err,
		s_error			   = @s_error,
		s_sev			   = @s_sev,
		s_msg			   = @s_msg,
		s_org			   = @s_org,
		t_debug			   = @t_debug,	
		t_file			   = @t_file,
		t_from			   = @t_from,
		i_tabla			   = @i_tabla
        exec cobis..sp_end_debug
end

if @i_operacion = "I"
begin

   if exists ( select siguiente
               from cob_conta..cb_seqnos
		 where tabla = @i_tabla and
                     empresa = @i_empresa)
      begin
      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 105001
           return 0
      end
   begin tran
         insert into cb_seqnos
	       	(bdatos,tabla,siguiente,pkey,empresa)
      	        values	("cob_conta",@i_tabla,0,@i_pkey,@i_empresa)
         if @@error <> 0
            begin
             /* error en insercion */
             exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 601157
             return 1
         end
    commit tran
    return 0
end 

begin tran
        /* si no existe el secuencial para la tabla dada, se crea */
	if not exists ( select siguiente
		 	  from cob_conta..cb_seqnos
			 where tabla = @i_tabla and
                               empresa = @i_empresa)
	begin
                exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 105001
                return 1
	end

        /* retornar el nuevo secuencial */
	select @o_siguiente = siguiente + 1
		from cob_conta..cb_seqnos
		where tabla = @i_tabla and
                      empresa = @i_empresa

        /* mensaje si secuencial llega al limite */
        if @o_siguiente = 2147483647
           print 'Secuencial llego al limite'

        /* sumar uno al secuencial de la tabla */
	update cb_seqnos
		set siguiente = @o_siguiente
		where tabla = @i_tabla and
                      empresa = @i_empresa

        /* si no se puede realizar la modificacion, error */
	if @@error != 0
	begin
                exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 105001
                return 1
	end

	if @t_debug = 'S'
	begin
        	exec cobis..sp_begin_debug @t_file = @t_file
        	select o_siguiente = @o_siguiente
        	exec cobis..sp_end_debug
	end

commit tran
go
