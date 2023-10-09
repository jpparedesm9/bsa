/************************************************************************/
/*      Archivo:                ad_dependencyMC.sql                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               Admin                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Vinculacion de modulos con ViewSerializer.dll                   */
/*      para determinados Roles y/o usuario                             */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      13/SEP/2012     MARIO VELEZ P.                                  */
/*      12/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/

use cobis
go

/****************************************************************************************************/
/***************************** MODULO ADMIN SEGURIDADES *********************************************/
/****************************************************************************************************/

declare @w_mo_id1   int, --Id modulo de la Dll con implementacion M&C  (COBISCorp.tCOBIS.ADMSEG.Functional.dll)
        @w_mo_id2   int, --Id modulo de la Dll con implementacion M&C  (COBISCorp.tCOBIS.ADMSEG.Role.dll)
        @w_mo_id_vs int, --Id modulo de la Dll Serializable M&C        (COBISCorp.eCOBIS.MC.ViewSerializer.dll)
        @w_mo_id_parent int

select @w_mo_id_vs = mo_id from an_module 
where mo_filename = 'COBISCorp.eCOBIS.MC.ViewSerializer.dll' 

/****INICIO: Aquí van todos los modulos que tienen vistas con implementación M&C y que se deben vincular con la COBISCorp.eCOBIS.MC.ViewSerializer.dll****/
   --Modulo de Admin Seguridades con implementacion M&C
   select @w_mo_id1 = mo_id from an_module 
   where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Functional.dll' 

   --Modulo de Admin Seguridades con implementacion M&C
   select @w_mo_id2 = mo_id from an_module 
   where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Role.dll' 
/****FIN de todos los modulos que tienen vistas con implementación M&C****/


/****Actualizar el modulo de dependencia del proyecto con M&C los cuales dependerán del COBISCorp.eCOBIS.MC.ViewSerializer.dll****/
   --Se deberá navegar hasta la librería con mo_id_parent igual a 0
   while (1=1)
   begin
      select @w_mo_id_parent = mo_id_parent,
             @w_mo_id1       = mo_id
      from an_module where mo_id = @w_mo_id1 and
                           mo_id_parent <> @w_mo_id_vs 
      if @@rowcount = 0


         break      
      if @w_mo_id_parent = 0
      begin
         update an_module set mo_id_parent = @w_mo_id_vs where mo_id = @w_mo_id1 --Cambio el mo_id_parent del modulo COBISCorp.tCOBIS.ADMSEG.Functional.dll
         break      
      end
      select @w_mo_id1 = @w_mo_id_parent    
   end
   
   ---------------------------------------
   --Se deberá navegar hasta la librería con mo_id_parent igual a 0
   while (1=1)
   begin
      select @w_mo_id_parent = mo_id_parent,
             @w_mo_id2       = mo_id
      from an_module where mo_id = @w_mo_id2 and
                           mo_id_parent <> @w_mo_id_vs 
      if @@rowcount = 0
         break      
      if @w_mo_id_parent = 0
      begin
         update an_module set mo_id_parent = @w_mo_id_vs where mo_id = @w_mo_id2 --Cambio el mo_id_parent del modulo COBISCorp.tCOBIS.ADMSEG.Role.dll
         break      
      end
      select @w_mo_id2 = @w_mo_id_parent    
   end

/****Dar permisos Insertando las dependencias en an_module_dependency****/
   if exists(select 1 from an_module_dependency where md_mo_id = @w_mo_id1 and md_dependency_id = @w_mo_id_vs )
      print 'El modulo COBISCorp.tCOBIS.ADMSEG.Functional.dll ya esta vinculado a COBISCorp.eCOBIS.MC.ViewSerializer.dll'
   else
   begin
      insert into an_module_dependency values(@w_mo_id1 ,@w_mo_id_vs)
      print 'El modulo COBISCorp.tCOBIS.ADMSEG.Functional.dll se ha vinculado a COBISCorp.eCOBIS.MC.ViewSerializer.dll'
   end
   ----------------------------------------
   if exists(select 1 from an_module_dependency where md_mo_id = @w_mo_id2 and md_dependency_id = @w_mo_id_vs )
      print 'El modulo COBISCorp.tCOBIS.ADMSEG.Role.dll ya esta vinculado a COBISCorp.eCOBIS.MC.ViewSerializer.dll'
   else
   begin
      insert into an_module_dependency values(@w_mo_id2 ,@w_mo_id_vs)
      print 'El modulo COBISCorp.tCOBIS.ADMSEG.Role.dll se ha vinculado a COBISCorp.eCOBIS.MC.ViewSerializer.dll'
   end
go



