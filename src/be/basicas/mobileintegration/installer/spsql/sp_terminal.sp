/***********************************************************************/
/*     Archivo:                sp_terminal.sp                          */
/*     Stored procedure:       sp_terminal		                       */
/*     Base de datos:          cob_sincroniza                          */
/*     Producto:               Cobis                                   */
/*     Disenado por:                                                   */
/*     Fecha de escritura:     10/Nov/2015                             */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                              PROPOSITO                              */
/*     Este programa contiene la gestion de la entidad  terminal       */
/***********************************************************************/
/*                              MODIFICACIONES                         */
/*     FECHA             AUTOR                 RAZON                   */
/*     15/Nov/2015                             Emision inicial         */
/***********************************************************************/

use cob_sincroniza
go

if object_id('sp_terminal') is not null
begin
    drop procedure sp_terminal
end
go


create proc sp_terminal(
  @s_ssn            int         = NULL,
  @s_user           login       = NULL,
  @s_term           varchar(32) = NULL,
  @s_date           datetime    = NULL,
  @s_sesn           int         = NULL,
  @s_culture        varchar(10) = NULL,
  @s_srv            varchar(30) = NULL,
  @s_lsrv           varchar(30) = NULL,
  @s_ofi            smallint    = NULL,
  @s_rol            smallint    = NULL,
  @s_org_err        char(1)     = NULL,
  @s_error          int         = NULL,
  @s_sev            tinyint     = NULL,
  @s_msg            descripcion = NULL,
  @s_org            char(1)     = NULL,
  @t_debug          char(1)     = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_trn            smallint    = null,
  @t_show_version   bit         = 0,
  @i_operacion      char(1),              -- Opcion con la que se ejecuta el programa
  @i_mac 			varchar(30) = null,
  @i_mac1 			varchar(30) = null,
  @i_mac2 			varchar(30) = null,
  @i_reference1 	varchar(50) = null,
  @i_reference2 	varchar(50) = null

)
as
declare @w_sp_name                    varchar(32),
		@w_num_error                  int,
		@w_count                      int

select @w_sp_name = 'sp_terminal'
/*--VERSIONAMIENTO--*/
if @t_show_version = 1
   begin
      print 'Stored procedure ' + @w_sp_name + ' Version 4.0.0.35'
      return 0
   end
/*--FIN DE VERSIONAMIENTO--*/
 
/*search*/
if @i_operacion = 'S'
begin
  SELECT 'mac' = te_mac,
  		 'mac1' = te_mac1,
  		 'mac2' = te_mac2,
  		 'reference1' = te_reference1,
  		 'reference2' = te_reference2
  from cob_sincroniza..si_terminal    
  WHERE  (te_mac = @i_mac or te_mac1 = @i_mac1  or te_mac2 = @i_mac2
  			OR @i_mac IS NULL OR @i_mac1 IS NULL OR @i_mac2 IS null)
  and (te_reference1 like @i_reference1 OR @i_reference1 IS NULL) 
  and (te_reference2 like @i_reference2 OR @i_reference2 IS NULL)  
END


/*insert*/
if @i_operacion = 'I'
BEGIN

  IF EXISTS (SELECT 1 FROM si_terminal WHERE te_mac = @i_mac)
  BEGIN
   SELECT @w_num_error = 801082 --YA EXISTE
   goto ERROR
  END

  INSERT INTO si_terminal (te_mac ,te_mac1,te_mac2,te_reference1,te_reference2) 
  				VALUES (@i_mac,@i_mac1,@i_mac2,@i_reference1,@i_reference2)
  				
  	if @@error != 0
      begin
         select @w_num_error =  357043 
         goto ERROR
      end 
END



/*update*/
if @i_operacion = 'U'
BEGIN


  update si_terminal
    set te_mac1=isnull(@i_mac1,te_mac1),
    	te_mac2=isnull(@i_mac2,te_mac2),
    	te_reference1=isnull(@i_reference1,te_reference1),
    	te_reference2=isnull(@i_reference2,te_reference2)   
    where te_mac=@i_mac 
   
   	if @@error != 0
      begin
         select @w_num_error =   355519
         goto ERROR
      end 


END

/*delete*/
if @i_operacion = 'D'
BEGIN

	DELETE FROM si_terminal WHERE te_mac = @i_mac
	
	if @@error != 0
      begin
         select @w_num_error =   710567 
         goto ERROR
      end 

END 

/*query*/
if @i_operacion = 'Q'
BEGIN
    select @w_count= count(*) from cob_sincroniza..si_terminal where te_mac in (@i_mac, @i_mac1, @i_mac2) or te_mac1 in (@i_mac, @i_mac1, @i_mac2)  or te_mac2 in (@i_mac, @i_mac1, @i_mac2)
    select times_found = @w_count
END 


RETURN 0

ERROR:
    EXEC cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error

    RETURN 1
GO