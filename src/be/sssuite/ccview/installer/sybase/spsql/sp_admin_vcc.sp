use cob_pac
go
if object_id('sp_admin_vcc') is not null
begin
  drop procedure sp_admin_vcc
end
go
Create Procedure sp_admin_vcc(   
/********************************************************************/
/*   ARCHIVO:         sp_admin_vcc.sp                               */
/*   NOMBRE LOGICO:   sp_admin_vcc                                  */
/*   PRODUCTO:        Vista Consolidada                             */
/********************************************************************/
/*              IMPORTANTE                                          */
/*  Este programa es parte de los paquetes bancarios propiedad de   */
/*  'COBISCORP S.A'.                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno de sus         */
/*  usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de COBISCORP S.A                          */
/********************************************************************/
/*                     PROPOSITO                                    */
/*   Realiza la administración de la tabla vcc_product_admin de la  */
/*   Administración de la Vista Consolidada de Clientes             */
/********************************************************************/
/*                     MODIFICACIONES                               */
/*   FECHA                 AUTOR                    RAZON           */
/*   21/Ene/2014       Aldo Benavides          Emision Inicial      */
/********************************************************************/
   
   @i_pr_id            numeric      = null  ,
   @i_pr_rol_id        int          = null  ,
   @i_pr_mnemonic      char(5)      = null,
   @i_pr_name          varchar(64)  = null  ,
   @i_pr_description   varchar(255) = null,
   @i_pr_parent        numeric      = null  ,
   @i_pr_isvisible     bit          = 1  ,
   @i_pr_isencrypted   bit          = 0 ,
   @i_pr_rol_name      varchar(64)  = null,
   @i_operacion        char(1)      = null    
)
as
  declare
   @w_pr_id            numeric     ,
   @w_pr_rol_id        int         ,
   @w_pr_mnemonic      char(5)     ,
   @w_pr_name          varchar(64) ,
   @w_pr_description   varchar(255),
   @w_pr_parent        numeric     ,
   @w_pr_isvisible     bit         ,
   @w_pr_isencrypted   bit         ,
   @w_pr_rol_name      varchar(64) ,
   @w_error            int   


if @i_operacion = 'I'
begin

INSERT INTO vcc_product_admin
	(
	  prd_id,
	  pr_rol_id,	  
	  pr_isvisible,
	  pr_isencrypted,
	  pr_rol_name
	)
SELECT 
      prd_id,
	  @i_pr_rol_id,	  
	  1,                      -- visible = true
	  0,                      -- encripted = false
	  @i_pr_rol_name
 FROM vcc_pro_admin_default	

  if @@error <> 0 
    begin  /* Error en Insercion de Registro */
      select @w_error = 731001
      return @w_error 
    end   

end   

if @i_operacion = 'U'
begin
UPDATE vcc_product_admin
   SET pr_isvisible   = @i_pr_isvisible,
   	   pr_isencrypted = @i_pr_isencrypted   	   
WHERE prd_id      = @i_pr_id
  AND pr_rol_id   = @i_pr_rol_id
  
  if @@error <> 0 
  begin  /* Error en Actualizacion de Registro */
    select @w_error = 731002
    return @w_error 
  end  
  if @@rowcount = 0 
  begin  /* Registro no Existe */
    select @w_error = 731003
    return @w_error 
  end 
end 

if @i_operacion = 'D'
begin

DELETE vcc_product_admin
 WHERE pr_rol_id = @i_pr_rol_id
 
  if @@error <> 0 
  begin  /* Error en Eliminacion de Registro */
    select @w_error = 731004
    return @w_error 
  end  
end 

if @i_operacion = 'E'
begin

SELECT prd_id,
	   -1,
	   prd_mnemonic,
	   prd_name,
	   prd_description,
	   prd_parent,
	   1,                          --visible = true
	   0,                          --encripted = false
	   'ROL_DEFAULT_VCC'
  FROM vcc_pro_admin_default
end 

if @i_operacion = 'Q'
begin

SELECT p.prd_id,
	   pr_rol_id,
	   prd_mnemonic,
	   prd_name,
	   prd_description,
	   prd_parent,
	   pr_isvisible,
	   pr_isencrypted,
	   pr_rol_name
  FROM vcc_product_admin p,
       vcc_pro_admin_default d
 WHERE pr_rol_id = @i_pr_rol_id
   AND p.prd_id = d.prd_id
 
  if @@rowcount =  0
   begin  /* Registro no Existe */
    select @w_error = 731006
    return @w_error 
  end  
end 

if @i_operacion = 'C'
begin
  SELECT DISTINCT pr_rol_id, pr_rol_name 
    FROM vcc_product_admin

  if @@rowcount = 0 
  begin  /* No Existen Roles Configurados */
    select @w_error = 731007
    return @w_error 
  end 
end 

if @i_operacion = 'R'
begin
   SELECT ro_rol, ro_descripcion 
     FROM cobis..ad_rol
  
  if @@rowcount = 0 
  begin  /* No existen roles Asociados a la VCC */
    select @w_error = 731008
    return @w_error 
  end 	  
end 

return 0    

go
