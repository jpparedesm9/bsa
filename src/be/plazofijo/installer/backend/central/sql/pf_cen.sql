/************************************************************************/
/*      Archivo           : pf_cen.sql                                  */
/*      Base de datos     : cobis                                       */
/*      Producto          : Plazo Fijo                                  */
/*      Disenado por      : ALF                                         */
/*      Fecha de escritura: 20/Mar/2015                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      COBISCORP                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                             PROPOSITO                                */
/*      Creacion de Menu CEN para Plazo Fijo                            */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA             AUTOR             RAZON                       */
/*      20/Mar/2015       A. Lf             Migracion                   */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go
-- BORRADO DE TABLAS --

delete cobis..an_module_dependency 
from cobis..an_module_dependency, 
     cobis..an_module
where mo_name like ('PFI%') 
  and mo_id_parent <> 0
  and md_mo_id = mo_id 
  and md_dependency_id = mo_id_parent
  
delete cobis..an_role_page 
from cobis..an_role_page, 
     cobis..an_page, 
     cobis..an_label 
where rp_pa_id = pa_id 
  and pa_la_id = la_id 
  and la_prod_name in ('M-PFI')
  
delete cobis..an_module_group 
where mg_name like ('PFI%')

delete cobis..an_page_zone 
from cobis..an_page_zone, 
     cobis..an_label 
where pz_la_id = la_id 
  and la_prod_name in ('M-PFI')
  
delete cobis..an_role_module 
from cobis..an_role_module, 
     cobis..an_module, 
     cobis..an_label 
where rm_mo_id = mo_id 
  and mo_la_id = la_id 
  and la_prod_name in ('M-PFI')
  
delete cobis..an_navigation_zone 
from cobis..an_navigation_zone, 
     cobis..an_label 
where nz_la_id = la_id 
  and la_prod_name in ('M-PFI')
  
delete cobis..an_role_component 
from cobis..an_role_component,
     cobis..an_component 
where rc_co_id = co_id 
and co_prod_name in ('M-PFI')

delete cobis..an_module 
from cobis..an_module, 
     cobis..an_label 
where mo_la_id = la_id 
  and la_prod_name in ('M-PFI')
  
delete cobis..an_component 
where co_prod_name in ('M-PFI')

delete cobis..an_page 
from cobis..an_page, 
     cobis..an_label 
where pa_la_id = la_id 
  and la_prod_name in ('M-PFI')
  
delete cobis..an_label 
where la_prod_name in ('M-PFI')

delete cobis..an_role_install 
where ri_prod_name = 'M-PFI'

delete an_transaction_component 
where tc_tn_trn_code between 14000 and 14999
  and tc_oc_nemonic is null

delete an_transaction_component 
where tc_oc_nemonic = 'M-PFI'
go 

-- ROLE INSTALL --

declare @w_rol   int,
        @w_rol2  int,
        @w_zo_id int

select @w_rol  = min(ro_rol)
from ad_rol
where ro_descripcion = 'ADMINISTRADOR DPF'

select @w_rol2 = min(ro_rol)
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

if OBJECT_ID(N'tempdb..#rol', N'U') is not null
   drop table #rol

create table #rol (rol int null) 

insert into #rol 
values (@w_rol)
insert into #rol 
values (@w_rol2)

delete an_role_install
from #rol
where ri_prod_name = 'M-PFI' 
  and ri_role      = rol

insert into an_role_install 
select 'M-PFI', rol
from #rol
where rol is not null

if not exists (select 1
               from an_zone
               where zo_name like 'Zona Vista Unica')
begin
     select @w_zo_id = isnull(max(zo_id),0) + 1
     from cobis..an_zone     

     insert into cobis..an_zone values (@w_zo_id, 'Zona Vista Unica', 1, 0, 0, 1)
end
go	   

declare @w_id_module_group      int,
        @w_module_group         varchar(50),
        @w_id_module            int,
        @w_module               varchar(50),
        @w_id_label_module      int,
        @w_label_module         varchar(50),
        @w_id_parent_module     int,
        @w_parent_module        varchar(50),
        @w_prod_name            varchar(10),
        @w_culture              varchar(10),
        @w_version              varchar(15),
        @w_localizacion         varchar(255),
        @w_store_name           varchar(40),
        @w_filename_module      varchar(255),
        @w_namespace_component  varchar(255),
        @w_name_component       varchar(255),
        @w_id_component         int,
        @w_class_component      varchar(50),
        @w_type                 varchar(10)

if OBJECT_ID(N'tempdb..#component', N'U') is not null
   drop table #component
		
create table #component
(id        numeric(10,0) identity,
 name      varchar(64),
 class     varchar(64),
 args      varchar(64),
 idmod     int           null,
 namesp    varchar(64)   null,
 trn       varchar(500)  null   --las transacciones de cada componente separadas por comas ejm: '14152,14543'--
)
		
-- Inicio  Resources

select @w_prod_name           = 'M-PFI',
       @w_module_group        = 'PFI.Resources',
       @w_module              = 'PFI.Resources',
       @w_label_module        = 'PFI.Resources',
       @w_namespace_component = 'COBISCorp.tCOBIS.PFI.Resources',
       @w_version             = '4.0.0.10',
       @w_localizacion        = 'http://[servername]/PFI.Resources.Installer/PFI.Resources.Installer.application',
       @w_parent_module       = null,
       @w_culture             = 'ES_EC',
       @w_store_name          = 'M-PFI', 
       @w_type                = 'SV'

-- MODULE GROUP: PFI.Resources --
print '--> Registros para Creacion de Modulo: PFI.Resources'

select @w_id_module_group = isnull(max(mg_id),0) + 1
from cobis..an_module_group

insert into cobis..an_module_group 
       (mg_id,              mg_name,           mg_version,     mg_location,        mg_store_name)
values (@w_id_module_group, @w_module_group,   @w_version,     @w_localizacion,    @w_store_name)

-- MODULE: PFI.Resources --
select @w_filename_module = @w_namespace_component + '.dll'

select @w_id_label_module = isnull(max(la_id), 0) + 1
from cobis..an_label

insert into cobis..an_label 
       (la_id,              la_cod,     la_label,           la_prod_name)
values (@w_id_label_module, @w_culture, @w_label_module,    @w_prod_name)
      
select @w_id_parent_module = isnull(mo_id,0)
from cobis..an_module
where mo_name = @w_parent_module	  
	  
select @w_id_module = isnull(max(mo_id), 0) + 1
from cobis..an_module

insert into cobis..an_module 
       (mo_id,        mo_mg_id,           mo_la_id,            mo_name,      mo_filename,        mo_id_parent,          mo_key_token)
values (@w_id_module, @w_id_module_group, @w_id_label_module,  @w_module,    @w_filename_module, @w_id_parent_module,   null)

insert into cobis..an_role_module 
select @w_id_module, rol
from #rol
where rol is not null  

-- Fin  Resources

		
select @w_prod_name           = 'M-PFI',
       @w_module_group        = 'PFI.SharedLibrary',
       @w_module              = 'PFI.SharedLibrary',
       @w_label_module        = 'PFI.SharedLibrary',
       @w_namespace_component = 'COBISCorp.tCOBIS.PFI.SharedLibrary',
       @w_version             = '4.0.0.10',
       @w_localizacion        = 'http://[servername]/PFI.SharedLibrary.Installer/PFI.SharedLibrary.Installer.application',
       @w_parent_module       = 'PFI.Resources',
       @w_culture             = 'ES_EC',
       @w_store_name          = 'M-PFI',
       @w_type                = 'SV'

 


-- MODULE GROUP: PFI.SharedLibrary --
print '--> Registros para Creacion de Modulo: PFI.SharedLibrary'

select @w_id_module_group = isnull(max(mg_id),1)+1
from cobis..an_module_group

insert into cobis..an_module_group 
       (mg_id,              mg_name,           mg_version,     mg_location,        mg_store_name)
values (@w_id_module_group, @w_module_group,   @w_version,     @w_localizacion,    @w_store_name)

-- MODULE: PFI.SharedLibrary --
select @w_filename_module = @w_namespace_component + '.dll'

select @w_id_label_module = isnull(max(la_id), 1) + 1
from cobis..an_label

insert into cobis..an_label 
       (la_id,              la_cod,        la_label,           la_prod_name)
values (@w_id_label_module, @w_culture,    @w_label_module,    @w_prod_name)

select @w_id_parent_module = isnull(mo_id,0)
from cobis..an_module
where mo_name = @w_parent_module

select @w_id_module = isnull(max(mo_id), 1) + 1
from cobis..an_module

insert into cobis..an_module 
       (mo_id,        mo_mg_id,           mo_la_id,             mo_name,      mo_filename,        mo_id_parent,          mo_key_token)
values (@w_id_module, @w_id_module_group, @w_id_label_module,   @w_module,    @w_filename_module, @w_id_parent_module,   null)

if isnull(@w_id_parent_module,0) > 0
   insert into cobis..an_module_dependency values (@w_id_module, @w_id_parent_module)

insert into cobis..an_role_module 
select @w_id_module, rol
from #rol
where rol is not null  
	   
insert into #component (name, class, args, trn)
values ('PFI.SharedLibrary.grid_valores','grid_valoresClass','','568,1502,1555,1556,1562,1571,1572,1574,1577,15031,15093,15168,15222,1579,15098,132,1182,1190,1215,1218,1229,1489,1490,1491,1492,1493,1241,1992,1626,14444,14439,14461')

update #component
set idmod  = @w_id_module,
    namesp = @w_namespace_component
where idmod is null
		
select @w_prod_name           = 'M-PFI',
       @w_module_group        = 'PFI.Management',
       @w_module              = 'PFI.Management',
       @w_label_module        = 'PFI.Management',
       @w_namespace_component = 'COBISCorp.tCOBIS.PFI.Management',
       @w_version             = '4.0.0.10',
       @w_localizacion        = 'http://[servername]/PFI.Management.Installer/PFI.Management.Installer.application',
       @w_parent_module       = 'PFI.SharedLibrary',
       @w_culture             = 'ES_EC',
       @w_store_name          = 'M-PFI', 
       @w_type                = 'SV'


-- MODULE GROUP: PFI.Management --
print '--> Registros para Creacion de Modulo: PFI.Management'

select @w_id_module_group = isnull(max(mg_id),0) + 1
from cobis..an_module_group

insert into cobis..an_module_group 
       (mg_id,              mg_name,           mg_version,     mg_location,        mg_store_name)
values (@w_id_module_group, @w_module_group,   @w_version,     @w_localizacion,    @w_store_name)

-- MODULE: PFI.Management --
select @w_filename_module = @w_namespace_component + '.dll'

select @w_id_label_module = isnull(max(la_id), 0) + 1
from cobis..an_label

insert into cobis..an_label 
       (la_id,              la_cod,     la_label,           la_prod_name)
values (@w_id_label_module, @w_culture, @w_label_module,    @w_prod_name)
      
select @w_id_parent_module = isnull(mo_id,0)
from cobis..an_module
where mo_name = @w_parent_module	  
	  
select @w_id_module = isnull(max(mo_id), 0) + 1
from cobis..an_module

insert into cobis..an_module 
       (mo_id,        mo_mg_id,           mo_la_id,            mo_name,      mo_filename,        mo_id_parent,          mo_key_token)
values (@w_id_module, @w_id_module_group, @w_id_label_module,  @w_module,    @w_filename_module, @w_id_parent_module,   null)

if isnull(@w_id_parent_module,0) > 0
   insert into cobis..an_module_dependency values (@w_id_module, @w_id_parent_module)

insert into cobis..an_role_module 
select @w_id_module, rol
from #rol
where rol is not null  

insert into #component (name, class, args, trn)
values ('PFI.Management.FTipoDepositos','FTipoDepositosClass','','6517,6518,14748,14334,14134,14234,14136,14148,14237,14344,14634,14436,14510,14434,14510,14518,14635,14135,14335,14310,14110')
insert into #component (name, class, args, trn)
values ('PFI.Management.FCatalogo','FCatalogoClass','','1578,1564,585,1564,585,584,14742')
insert into #component (name, class, args, trn)
values ('PFI.Management.FFrecuen','FFrecuenClass','','14743,14521,14421,14221,14121,14321')
insert into #component (name, class, args, trn)
values ('PFI.Management.FTiPlazo','FTiPlazoClass','','14745,14514,14214,14114,14514,14314')
insert into #component (name, class, args, trn)
values ('PFI.Management.FTiMonto','FTiMontoClass','','14746,14512,14112,14212,14312')
insert into #component (name, class, args, trn)
values ('PFI.Management.FTiProrr','FTiProrrClass','','14172,14272,14372,14572')
insert into #component (name, class, args, trn)
values ('PFI.Management.FForPago','FForPagoClass','','6517,6518,14747,14532,14132,14330,14232')
insert into #component (name, class, args, trn)
values ('PFI.Management.FDefPerfiles','FDefPerfilesClass','','14810,14935')
insert into #component (name, class, args, trn)
values ('PFI.Management.FCambTasas','FCambTasasClass','','14546,14612,14614,14240')
insert into #component (name, class, args, trn)
values ('PFI.Management.FLECARCH','FLecturaArchivoClass','','14173,14273,14373,14473,14573,14673')
insert into #component (name, class, args, trn)
values ('PFI.Management.FAutorifuncionario','FAutorifuncionarioClass','','14633')                                             
update #component
set idmod  = @w_id_module,
    namesp = @w_namespace_component
where idmod is null

select @w_prod_name           = 'M-PFI',
       @w_module_group        = 'PFI.Operation',
       @w_module              = 'PFI.Operation',
       @w_label_module        = 'PFI.Operation',
       @w_namespace_component = 'COBISCorp.tCOBIS.PFI.Operation',
       @w_version             = '4.0.0.10',
       @w_localizacion        = 'http://[servername]/PFI.Operation.Installer/PFI.Operation.Installer.application',
       @w_parent_module       = 'PFI.SharedLibrary',
       @w_culture             = 'ES_EC',
       @w_store_name          = 'M-PFI', 
       @w_type                = 'SV'

-- MODULE GROUP: PFI.Operation --
print '--> Registros para Creacion de Modulo: PFI.Operation'

select @w_id_module_group = isnull(max(mg_id),0) + 1
from cobis..an_module_group

insert into cobis..an_module_group 
       (mg_id,              mg_name,           mg_version,     mg_location,        mg_store_name)
values (@w_id_module_group, @w_module_group,   @w_version,     @w_localizacion,    @w_store_name)

-- MODULE: PFI.Operation --
select @w_filename_module = @w_namespace_component + '.dll'

select @w_id_label_module = isnull(max(la_id), 0) + 1
from cobis..an_label

insert into cobis..an_label 
       (la_id,              la_cod,     la_label,           la_prod_name)
values (@w_id_label_module, @w_culture, @w_label_module,    @w_prod_name)
      
select @w_id_parent_module = isnull(mo_id,0)
from cobis..an_module
where mo_name = @w_parent_module	  
	  
select @w_id_module = isnull(max(mo_id), 0) + 1
from cobis..an_module

insert into cobis..an_module 
       (mo_id,        mo_mg_id,           mo_la_id,            mo_name,      mo_filename,        mo_id_parent,          mo_key_token)
values (@w_id_module, @w_id_module_group, @w_id_label_module,  @w_module,    @w_filename_module, @w_id_parent_module,   null)

if isnull(@w_id_parent_module,0) > 0
   insert into cobis..an_module_dependency values (@w_id_module, @w_id_parent_module)

insert into cobis..an_role_module 
select @w_id_module, rol
from #rol
where rol is not null  

insert into #component (name, class, args, trn)
values ('PFI.Operation.FApertura','FAperturaClass','modoOperacion=I','1565,1574,1577,15001,1493,1182,1215,1229,1283,1386,1190,1489,1218,1318,1241,79,230,3008,3010,3016,3020,1386,14901,14416,14950,14439,14446,14435,14946,14111,14127,14634,14636,14633,14632,14440,14946,14401,14447,14812,14445,14137,14113,14638,14138,14153,14766')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FModificacion','FModificaOpClass','modoOperacion=U','1565,1574,1577,15001,1493,1182,1215,1229,1283,1386,1190,1489,1218,1318,1241,79,230,3008,3010,3016,3020,1386,14901,14416,14950,14439,14446,14435,14946,14111,14127,14634,14636,14633,14632,14440,14946,14401,14447,14812,14445,14137,14113,14638,14138,14153')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FAnulacion','FAnulacionClass','tipoReverso=AN','14908,14633')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FActivaDeposito','FActivaDepositoClass','','1182,1318,1241,1386,1283,79,230,3008,3010,3016,3020,14914,14542,14806,14401,14637,14638,14639,14640,14643,14984,14338')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FModificaAct','FModificaActClass','modoOperacion=M','1182,1318,1241,1386,1283,1489,1215,1229,14165,14806,14158,14468,14554,14634,14637,14639,14446,14812,14636,14111,14638,14137,14337,14113,14401,14435')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FRevActCanc','FRevActCancClass','tipoReverso=A','14915,14633')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FReversoCancelacion','FReversoCancelacionClass','tipoReverso=C','14913,14633')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FReversoRenovacion','FReversoRenovacionClass','tipoReverso=R','14929,14633')
insert into #component (name, class, args, trn)
values ('PFI.Operation.Frevcanc','FRetiroCancelacionClass','tipoReverso=IR','14909,14705,14633,14401')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FRevordpago','FRevordpagoClass','','1182,1318,1241,1386,14712,14767,14806,14401,14127,14633')
--insert into #component (name, class, args, trn)
--values ('PFI.Operation.FRevPagoInt','FRevPagoIntClass','','1182,1318,1241,1386,14768,14806,14401,14446,14637,14463,14812,14632,14153,14440,14445,14137,14337')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FEndosos','FEndososClass','','1182,1318,1241,1386,1489,1283,1492,14709,14149,14401,14806,14637,14638,14812,14632,14440,14445,14137,14113')
--insert into #component (name, class, args, trn)
--values ('PFI.Operation.FIncrementoReduccion','FModificaActClass','modoOperacion=I','1182,1318,1241,1386,79,230,3008,3010,3016,3020,14709,14965,14401,14806,14158,14468,14554,14637,14637,14634,14446,14812,14636,14111,14638,14137,14337,14327,14632,14440,14445,14127,14138,14153')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FAutSpr','FAutSprClass','','1182,1318,1241,1386,14709,14159,14806,14401,14554')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FCancelacionNormal','FCancelacionNormalClass','','1182,1318,1241,1386,14718,14903,14806,14401,14637,14438,14632,14440,14445,14446,14137,14337,14327,14299,14127')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FCancelacionAnticipada','FCancelacionAnticipadaClass','','1182,1318,1241,1386,14719,14903,14806,14401,14637,14438,14632,14440,14445,14137,14337,14327,14299,14127,14446,14554')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FIngProblemas','FIngProblemasClass','','1182,1318,1241,1386,14720,14543,14806,14401,14447,14637,14642,14139,14339')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FRenovaOpClass','FRenovaOpClass','modoOperacion=R','1572,1190,1182,1241,1318,1386,1229,1215,79,230,3008,3010,3016,3020,14904,14806,14401,14158,14468,14637,14634,14445,14446,14812,14435,14636,14638,14111,14632,14440,14311,14337,14137,14113,14127,14153,14554')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FPagoAntIntereses','FPagoAntInteresesClass','','1182,1318,1241,1386,14155,14806,14401,14446,14637,14463,14812,14632,14153,14440,14445,14137,14337')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FEmisionOrdenes','FEmisionOrdenesClass','','1182,1318,1241,1386,14723,14806,14401,14446,14637,14532,14447,14531,14431,14231')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FRetencion','FRetencionClass','','1182,1318,1241,1386,14108,14806,14401')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FLevRetencion','FLevRetencionClass','','1182,1318,1241,1386,14308,14806,14401,14508,14408')

insert into #component (name, class, args, trn)
values ('PFI.Operation.FPignoracion','FPignoracionClass','','1182,1318,1241,1386,14107,14806,14401')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FLevPignoracion','FLevPignoracionClass','','1182,1318,1241,1386,14307,14806,14401,14507,14407')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FReimpOrig','FReimpOrigClass','','1182,1318,1241,1386,14729,14806,14401,14637,14463,14456')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FBCuotas','FBCuotasClass','','1182,1318,1241,1386,14451,14806,14401,14158,14637,14812,14463')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FReimpComAper','FReimpComAperClass','','14401,14638,14637,14639')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FFraccionamiento','FFraccionamientoClass','','14952,14327,14637,14401,14127')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FReimpOrig2','FReimpOrig2Class','','1182,1318,1241,1386,14729,14806,14401,14637,14463,14456')

insert into #component (name, class, args, trn)
values ('PFI.Operation.FReversoFusion','FReversoFusionClass','','14952')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FReversoFraccionamiento','FReversoFraccionamientoClass','','14952')
insert into #component (name, class, args, trn)
values ('PFI.SharedLibrary.uscDetCheques','uscDetChequesClass','','14952')

insert into #component (name, class, args, trn)
values ('PFI.Operation.FFusion','FFusionClass','','14952,14327,14637,14401,14127')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FEnajenacion','FEnajenacionClass','','14952,14327,14637,14401,14127')
insert into #component (name, class, args, trn)
values ('PFI.Operation.FDeceval','FDecevalClass','','14769,14401')


update #component
set idmod  = @w_id_module,
    namesp = @w_namespace_component
where idmod is null

select @w_prod_name           = 'M-PFI',
       @w_module_group        = 'PFI.Query',
       @w_module              = 'PFI.Query',
       @w_label_module        = 'PFI.Query',
       @w_namespace_component = 'COBISCorp.tCOBIS.PFI.Query',
       @w_version             = '4.0.0.10',
       @w_localizacion        = 'http://[servername]/PFI.Query.Installer/PFI.Query.Installer.application',
       @w_parent_module       = 'PFI.SharedLibrary',
       @w_culture             = 'ES_EC',
       @w_store_name          = 'M-PFI', 
       @w_type                = 'SV'

-- MODULE GROUP: PFI.Query --
print '--> Registros para Creacion de Modulo: PFI.Query'

select @w_id_module_group = isnull(max(mg_id),0) + 1
from cobis..an_module_group

insert into cobis..an_module_group 
       (mg_id,              mg_name,           mg_version,     mg_location,        mg_store_name)
values (@w_id_module_group, @w_module_group,   @w_version,     @w_localizacion,    @w_store_name)

-- MODULE: PFI.Query --
select @w_filename_module = @w_namespace_component + '.dll'

select @w_id_label_module = isnull(max(la_id), 0) + 1
from cobis..an_label

insert into cobis..an_label 
       (la_id,              la_cod,     la_label,           la_prod_name)
values (@w_id_label_module, @w_culture, @w_label_module,    @w_prod_name)
      
select @w_id_parent_module = isnull(mo_id,0)
from cobis..an_module
where mo_name = @w_parent_module	  
	  
select @w_id_module = isnull(max(mo_id), 0) + 1
from cobis..an_module

insert into cobis..an_module 
       (mo_id,        mo_mg_id,           mo_la_id,            mo_name,      mo_filename,        mo_id_parent,          mo_key_token)
values (@w_id_module, @w_id_module_group, @w_id_label_module,  @w_module,    @w_filename_module, @w_id_parent_module,   null)

if isnull(@w_id_parent_module,0) > 0
   insert into cobis..an_module_dependency values (@w_id_module, @w_id_parent_module)

insert into cobis..an_role_module 
select @w_id_module, rol
from #rol
where rol is not null  

insert into #component (name, class, args, trn)
values ('PFI.Query.FConsultaOp','FConsultaOpClass','','1182,1318,1241,1386,1283,14733,14168,14806,14401,14637,14638,14639,14640,14805,14643,14463,14507,14508,14559,14452,14464')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConsultaGe','FConsultaGeClass','','15001,15093,1574,1562,1577,1182,1318,1241,1386,1283,14734,14634,14702,14614,14612,14401,14637,14638,14639,14640,14805,14643,14463,14507,14508,14559,14452,14464')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConsultaEsp','FConsultaEspClass','','14534')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConsultaNeg','FConsultaNegClass','','15001,1182,1318,1241,1386,1283,14736,14634,14612,14614,14704,14401,14637,14638,14639,14640,14805,14643,14463,14507,14508,14559,14452,14464')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConsultaAut','FConsultaAutClass','','15001,1182,1318,1241,1386,1283,14737,14634,14612,14614,14401,14637,14638,14639,14640,14805,14643,14463,14507,14508,14559,14452,14464')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConTaVi','FConTaViClass','','14740,14634,14636,14804')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConHistoricaTasas','FConHistoricaTasasClass','','14540,14549,14634')
insert into #component (name, class, args, trn)
values ('PFI.Query.FConAperCan','FConAperCanClass','','15001,1182,1318,1241,1386,1283,14555,14634,14612,14614,14401,14637,14638,14639,14640,14805,14643,14463,14507,14508,14559,14452,14464')
insert into #component (name, class, args, trn)
values ('PFI.Query.FconsMov','FconsMovClass','','1182,1318,1241,1386,14462,14806,14158,14637')
insert into #component (name, class, args, trn)
values ('PFI.Query.FImpConfirmacion','FImpConfirmacionClass','','14811')
insert into #component (name, class, args, trn)
values ('PFI.Query.FCfrafus','FCfrafusClass','','14417')
insert into #component (name, class, args, trn)
values ('PFI.Query.Fcendoso','FConsultaEndosoClass','','14417')



update #component
set idmod  = @w_id_module,
    namesp = @w_namespace_component
where idmod is null


-- Registro de todos los componentes --

select @w_id_component = isnull(max(co_id), 0) + 1
from cobis..an_component

insert into cobis..an_component 
       (co_id,                  co_mo_id,               co_name,            co_class,           
        co_namespace,           co_ct_id,               co_arguments,       co_prod_name)
select  @w_id_component + id,   idmod,                  name,               class,
        namesp,                 @w_type,                args,               @w_prod_name 
from #component
go


declare @w_la_id         int,
        @w_pa_id         int,
        @w_pz_id         int,
        @w_pa_order      int,
        @w_pa_he_id      int,
        @w_la_cod        varchar(10),
        @w_pa_icon       varchar(40),
        @w_pa_splitter   varchar(20),
        @w_pa_arguments  varchar(255),
        @w_la_prod_name  varchar(10),
        @w_pa_id_parent  int,
        @w_pa_nemonic    varchar(40),
        @w_zo_id         int

select @w_la_cod       = 'ES_EC',
       @w_la_prod_name = 'M-PFI',
       @w_pa_icon      = 'icono pagina',
       @w_pa_id_parent = 0, 
       @w_pa_order     = 0,
       @w_pa_splitter  = 'horizontal',
       @w_pa_nemonic   = 'Nemonic',
       @w_pa_arguments = null,
       @w_pa_he_id     = null

-- PAGE: PFI --
if OBJECT_ID(N'tempdb..#page', N'U') is not null
   drop table #page

create table #page
(id     int           not null,
 name   varchar(64)   not null,
 parent int           null, 
 label  varchar(64)   not null,
 args   varchar(64)   not null,
 class  varchar(64)   null
)

insert into #page
values (1,'PFI',null,'Depositos a Plazo','',null)
insert into #page
values (2,'PFI.Administracion',1,  'Administracion','',null)
insert into #page
values (3,'PFI.Management.FTipoDepositos',2,'Tipos de Deposito','','FTipoDepositosClass')
insert into #page
values (4,'PFI.Management.FCatalogo',2,'Catalogos','','FCatalogoClass')
insert into #page
values (5,'PFI.Management.FFrecuen',2,'Frecuencias','','FFrecuenClass')
insert into #page
values (6,'PFI.Management.FTiPlazo',2,'Plazos','','FTiPlazoClass')
insert into #page
values (7,'PFI.Management.FTiMonto',2,'Montos','','FTiMontoClass')
insert into #page
values (8,'PFI.Management.FForPago',2,'Formas de Pago','','FForPagoClass')
insert into #page
values (9,'PFI.Management.FDefPerfiles',2,'Perfiles Contables','','FDefPerfilesClass')
insert into #page
values (10,'PFI.Management.FCambTasas',2,'Tasas Masivas','','FCambTasasClass')
insert into #page
values (11,'PFI.Management.FAutorifuncionario',2,'Autorizacion de Funcionario DPF','','FAutorifuncionarioClass')
insert into #page
values (12,'PFI.Operacion',1,'Operacion','',null)
insert into #page
values (13,'PFI.Operation.FApertura',12,'Apertura','','FAperturaClass')
insert into #page
values (14,'PFI.Operation.FModificacion',12,'Modificacion de Deposito Ingresado','','FModificaOpClass')
insert into #page
values (15,'PFI.Operation.FAnulacion',12,'Anulacion','','FAnulacionClass')
insert into #page
values (16,'PFI.Operation.FActivaDeposito',12,'Aprobacion y Activacion','','FActivaDepositoClass')
insert into #page
values (17,'PFI.Operation.FReversos',12,'Reversos','',null)
insert into #page
values (18,'PFI.Operation.FRevActCanc',17,'Reverso de Activacion','','FRevActCancClass')
insert into #page
values (19,'PFI.Operation.FReversoCancelacion',17,'Reverso de Cancelacion','','FReversoCancelacionClass')
insert into #page
values (20,'PFI.Operation.FReversoRenovacion',17,'Reverso de Renovacion','','FReversoRenovacionClass')
insert into #page
values (21,'PFI.Operation.FRevordpago',17,'Reverso de Ordenes de Pago','','FRevordpagoClass')
insert into #page
values (22,'PFI.Operation.Frevcanc',17,'Reverso Instruccion de Renovacion','','FRetiroCancelacionClass')
insert into #page
values (23,'PFI.Management.FLECARCH',2,'Carga Masiva Tasas','','FLecturaArchivoClass')
--insert into #page
--values (23,'PFI.Operation.FRevPagoInt',17,'Reverso de Pago de Interes','','FRevPagoIntClass')
insert into #page
values (24,'PFI.Operation.FTransacciones',12,'Transacciones Especiales','',null)
insert into #page
values (25,'PFI.Operation.FEndosos',24,'Endosos','','FEndososClass')
insert into #page
values (26,'PFI.Operation.FModificaAct',24,'Mantenimiento de Depositos','','FModificaActClass')
--insert into #page
--values (27,'PFI.Operation.FIncrementoReduccion',24,'Incremento / Reduccion de Capital','','FModificaAct2Class')
insert into #page
values (28,'PFI.Operation.FFraccionamiento',24,'Fraccionamiento','','FFraccionamientoClass')
insert into #page
values (29,'PFI.Operation.FAutSpr',24,'Autorizaciones','','FAutSprClass')
insert into #page
values (30,'PFI.Operation.FFusion',24,'Englobe','','FFusionClass')
insert into #page
values (31,'PFI.Operation.FEnajenacion',24,'Devolucion de Retencion','','FEnajenacionClass')
insert into #page
values (32,'PFI.Operation.FDeceval',24,'T+­tulos en Deceval','','FDecevalClass')

insert into #page
values (33,'PFI.Operation.FCancelacion',12,'Cancelacion','',null)
insert into #page
values (34,'PFI.Operation.FCancelacionNormal',33,'Cancelacion Normal','','FCancelacionNormalClass')
insert into #page
values (35,'PFI.Operation.FCancelacionAnticipada',33,'Cancelacion Anticipada','','FCancelacionAnticipadaClass')
insert into #page
values (36,'PFI.Operation.FIngProblemas',33,'Cancelacion por Cheque Devuelto','','FIngProblemasClass')
insert into #page
values (37,'PFI.Operation.FRenovaOpClass',12,'Renovacion','','FRenovaOpClass')
insert into #page
values (38,'PFI.Operation.FPagoAntIntereses',12,'Pago de Interes','','FPagoAntInteresesClass')
insert into #page
values (39,'PFI.Operation.FEmisionOrdenes',12,'Emision Orden de Pago','','FEmisionOrdenesClass')
insert into #page
values (40,'PFI.Operation.FBloqueos',12,'Bloqueos','',null)
insert into #page
values (41,'PFI.Operation.FRetencion',40,'Ingreso Bloqueo','','FRetencionClass')
insert into #page
values (42,'PFI.Operation.FLevRetencion',40,'Levantamiento Bloqueo','','FLevRetencionClass')


insert into #page
values (43,'PFI.Operation.FPignoraciones',12,'Pignoraciones','',null)
insert into #page
values (44,'PFI.Operation.FPignoracion',43,'Ingreso Pignoracion','','FPignoracionClass')
insert into #page
values (45,'PFI.Operation.FLevPignoracion',43,'Levantamiento Pignoracion','','FLevPignoracionClass')
insert into #page
values (46,'PFI.Operation.FImprimir',12,'Imprimir','',null)
insert into #page
values (47,'PFI.Operation.FReimpOrig',46,'Certificado / Contrato','','FReimpOrigClass')
insert into #page
values (48,'PFI.Operation.FBCuotas',46,'Cronograma de Pagos','','FBCuotasClass')
insert into #page
values (49,'PFI.Operation.FReimpComAper',46,'Comprobante de Apertura','','FReimpComAperClass')

insert into #page
values (50,'PFI.Operation.FReimpOrig2',46,'Reimpresion de Certificado','','FReimpOrig2Class')

insert into #page
values (51,'PFI.Operation.FReversoFusion',17,'Reverso Fusion','','FReversoFusionClass')
insert into #page
values (52,'PFI.Operation.FReversoFraccionamiento',17,'Reverso Fraccionamiento','','FReversoFraccionamientoClass')


insert into #page
values (53,'PFI.Query',1,'Consultas','',null)
insert into #page
values (54,'PFI.Query.FConsultaOp',53,'Detalle de Deposito','','FConsultaOpClass')
insert into #page
values (55,'PFI.Query.FConsultaGe',53,'General de Depositos','','FConsultaGeClass')
insert into #page
values (56,'PFI.Query.FConsultaEsp',53,'Productos Vigentes','','FConsultaEspClass')
insert into #page
values (57,'PFI.Query.FConsultaNeg',53,'Negociaciones','','FConsultaNegClass')
insert into #page
values (58,'PFI.Query.FConsultaAut',53,'Autorizaciones','','FConsultaAutClass')
insert into #page
values (59,'PFI.Query.FConTaVi',53,'Tasas Vigentes','','FConTaViClass')
insert into #page
values (60,'PFI.Query.FConHistoricaTasas',53,'Historico de Tasas','','FConHistoricaTasasClass')
insert into #page
values (61,'PFI.Query.FConAperCan',53,'Aperturas y Cancelaciones','','FConAperCanClass')
insert into #page
values (62,'PFI.Query.FconsMov',53,'Movimientos Monetarios','','FconsMovClass')
insert into #page
values (63,'PFI.Query.FImpConfirmacion',53,'Confirmaciones Automaticas','','FImpConfirmacionClass')
insert into #page
values (64,'PFI.Query.FCfrafus',53,'Consulta de Fracciones ','','FCfrafusClass')
insert into #page
values (65,'PFI.Query.Fcendoso',53,'Consulta de Endosos ','','FConsultaEndosoClass')
insert into #page
values (66,'PFI.Management.FTiProrr',2,'Prorrogas','','FTiProrrClass')

select @w_la_id = isnull(max(la_id), 0) + 1
from cobis..an_label

select @w_pa_id  = isnull(max(pa_id), 0) + 1
from cobis..an_page

insert into cobis..an_label
select @w_la_id + id, @w_la_cod, label, @w_la_prod_name
from #page
order by id

insert into cobis..an_page 
      (pa_id,            pa_la_id,        pa_name,                    pa_icon,         pa_id_parent,                 pa_order,
       pa_splitter,      pa_nemonic,      pa_prod_name,               pa_arguments,    pa_he_id)
select @w_pa_id + id,    @w_la_id + id,   convert(varchar(40),name),  @w_pa_icon,      isnull(parent + @w_pa_id,0),  id,
       @w_pa_splitter,   @w_pa_nemonic,   @w_la_prod_name,            args,            @w_pa_he_id
from #page
order by id



select @w_pz_id = isnull(max(pz_id), 0) + 1
from cobis..an_page_zone 

select @w_zo_id = zo_id
from cobis..an_zone
where zo_name like 'Zona Vista Unica'

select @w_zo_id = isnull(@w_zo_id,1)
insert into cobis..an_page_zone 
       (pz_id,         pz_zo_id,    pz_la_id,        pz_pa_id,      pz_co_id,               pz_order,   pz_hor_size,
        pz_ver_size,   pz_icon,     pz_split_style,  pz_id_parent,  pz_component_optional,  pz_he_id)
select  @w_pz_id + id, @w_zo_id,    @w_la_id + id,   @w_pa_id + id, co_id,                  1,          100,
        100,           'Ninguno',   @w_pa_splitter,  0,             1,                      null
from #page,
     cobis..an_component
where co_name  = name
  and co_class = class
order by id
go



insert into cobis..an_role_page 
select distinct pa_id, rol
from  cobis..an_page, #rol
where pa_prod_name = 'M-PFI'
and   rol is not null

insert into cobis..an_role_component 
select co_id, rol
from cobis..an_component,
     #rol
where co_prod_name = 'M-PFI'
  and rol is not null
go

set nocount on
go

print '--> Registro en Transaction Component'

declare @w_name  varchar(128),
        @w_trn   varchar(512),
        @w_qry   varchar(3500),
        @w_tabla int 


select @w_tabla = codigo
from cl_tabla
where tabla = 'an_product'

if isnull(@w_tabla,0) > 0
begin
      delete cl_catalogo
      where tabla  = @w_tabla
        and codigo = 'M-PFI'

      insert into cl_catalogo (tabla, codigo, valor, estado)
      select top 1 @w_tabla, 'M-PFI', pd_descripcion,  pd_estado
      from cl_producto
      where pd_producto = 14
end      


select @w_name = ''

while 1 = 1
begin
     select top 1
            @w_name = name,
            @w_trn  = trn
     from #component
     where name > @w_name
     order by name

     if @@rowcount = 0
        break

    -- print 'componente --> %1!', @w_name
     
     select @w_qry = 'delete an_transaction_component ' + 
                     'from cobis..an_component, ' +
                     '     cobis..cl_ttransaccion ' +
                     'where co_name      = '  + '''' + @w_name + '''' + 
                     '  and tn_trn_code in (' + @w_trn + ')' + 
                     '  and tc_tn_trn_code = tn_trn_code ' + 
                     '  and tc_co_id       = co_id '
     exec (@w_qry)


     select @w_qry = 'insert into an_transaction_component ' + 
                     'select distinct co_id, tn_trn_code, null ' +   -- + '''' + 'M-PFI' + '''' +
                     'from cobis..an_component, ' +
                     '     cobis..cl_ttransaccion ' +
                     'where co_name      = '  + '''' + @w_name + '''' + 
                     '  and tn_trn_code in (' + @w_trn + ')' 
     exec (@w_qry)
end

declare @w_codigo int
select @w_codigo = la_id
from cobis..an_label 
where la_label = 'Detalle Cheques'

delete cobis..an_label where la_label= 'Detalle Cheques'
delete cobis..an_page where pa_la_id = @w_codigo
go

set nocount off
go

print 'Menu de Reportes'
/********************************************************************/
/* Fecha:   17-Oct-2016                                             */
/* Objeto:  Script de creacion de Menu de reportes para CEN         */
/* Modulo:  Reportes - DPF                                          */
/* Autor:   Estiwar V. Carrion J.                                   */
/********************************************************************/

use cobis
go

declare @w_id_rol int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_id_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_id_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_id_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

/*ELIMINACAION TOTAL*/
delete from an_page_zone where pz_pa_id in (select pa_id from an_page where pa_name in ('PFI.Reportes',
																						'PFI.ReporteErroresBatch',
																						'PFI.ReporteDepositosBloqueados',
																						'PFI.ReporteProvisionAmortizacion',
																						'PFI.ReportePagosAutomaticosInteres',
																						'PFI.ReporteOperacionesMonetarias',
																						'PFI.ReporteDepositosDeceval'))
							   and pz_zo_id = (select zo_id from an_zone where zo_name = 'Zona WEB')
							   
delete from an_zone where zo_name = 'Zona WEB'

delete an_role_component where rc_co_id in (select co_id from an_component where co_name in (	'PFI.ReporteErroresBatch',
																								'PFI.ReporteDepositosBloqueados', 
																								'PFI.ReporteProvisionAmortizacion',
																								'PFI.ReportePagosAutomaticosInteres',
																								'PFI.ReporteOperacionesMonetarias',
																								'PFI.ReporteDepositosDeceval'))
						   and rc_rol = @w_id_rol
							
delete from an_component where co_name in ( 'PFI.ReporteErroresBatch',
											'PFI.ReporteDepositosBloqueados',
											'PFI.ReporteProvisionAmortizacion',
											'PFI.ReportePagosAutomaticosInteres',
											'PFI.ReporteOperacionesMonetarias',
											'PFI.ReporteDepositosDeceval')
									  
delete an_role_module where rm_mo_id in (select mo_id from an_module where mo_name in ('PFI.Reportes'))
					    and rm_rol = @w_id_rol
									  
delete from an_module where mo_name in ('PFI.Reportes')
									  
delete from an_module_group where mg_name in ('PFI.Reportes')	

delete an_role_page where rp_pa_id in (select pa_id from an_page where pa_name in (	'PFI.Reportes',
																					'PFI.ReporteErroresBatch',
																					'PFI.ReporteDepositosBloqueados',
																					'PFI.ReporteProvisionAmortizacion',
																					'PFI.ReportePagosAutomaticosInteres',
																					'PFI.ReporteOperacionesMonetarias',
																					'PFI.ReporteDepositosDeceval'))
					    and rp_rol = @w_id_rol								  

delete from an_page where pa_name in (	'PFI.Reportes',
										'PFI.ReporteErroresBatch',
										'PFI.ReporteDepositosBloqueados',
										'PFI.ReporteProvisionAmortizacion',
										'PFI.ReportePagosAutomaticosInteres',
										'PFI.ReporteOperacionesMonetarias',
										'PFI.ReporteDepositosDeceval')
go


declare @w_id_label int,
		@w_id_label_SP int,
		@w_id_page  int,
		@w_id_page_parent int,
		@w_id_modulegroup int,
		@w_id_module int,
		@w_id_zone int,
		@w_id_component int,
		@w_id_pagezone int,
		@w_ip_port varchar(20), 
		@w_id_parent             int  -- OGU 24/09/2015  Identificador de la pagina padre

/*MODIFICAR POR EL IP Y PUERTO CORRECTO*/		
select @w_ip_port = '192.168.103.218:80'
		
/*INSERCION DE ETIQUETAS*/

select @w_id_label = max(la_id) from an_label

-- Segundo nivel
IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Reportes' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Reportes', 'M-PFI' ) 
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Reports', 'M-PFI' ) 
END

-- Tercer Nivel

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Errores Batch' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Errores Batch', 'M-PFI' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Batch Errors', 'M-PFI' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Depositos Bloqueados' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Depositos Bloqueados', 'M-PFI' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Blocked Deposits', 'M-PFI' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Provision y Amortizacion' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Provision y Amortizacion', 'M-PFI' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Provision and Amortization', 'M-PFI' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Pagos Automaticos de Interes' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Pagos Automaticos de Interes', 'M-PFI' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Automatic Payments Interest', 'M-PFI' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Operaciones Monetarias' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Operaciones Monetarias', 'M-PFI' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Monetary Operations', 'M-PFI' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Depositos DECEVAL' AND la_prod_name = 'M-PFI')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Depositos DECEVAL', 'M-PFI' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'DECEVAL Deposits', 'M-PFI' ) 
END
/*INSERCION DE PAGINAS*/

select @w_id_page = max(pa_id) + 1 from an_page

-- Segundo nivel

select @w_id_page_parent = pa_id from an_page where pa_name = 'PFI' AND pa_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.Reportes' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Reportes' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.Reportes', 'icono pagina', @w_id_page_parent, 100, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

-- Tercer Nivel

select @w_id_page_parent = pa_id from an_page where pa_name = 'PFI.Reportes' AND pa_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.ReporteErroresBatch' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Errores Batch' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.ReporteErroresBatch', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.ReporteDepositosBloqueados' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Depositos Bloqueados' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.ReporteDepositosBloqueados', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.ReporteProvisionAmortizacion' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Provision y Amortizacion' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.ReporteProvisionAmortizacion', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.ReportePagosAutomaticosInteres' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Pagos Automaticos de Interes' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.ReportePagosAutomaticosInteres', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.ReporteOperacionesMonetarias' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Operaciones Monetarias' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.ReporteOperacionesMonetarias', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PFI.ReporteDepositosDeceval' AND pa_prod_name = 'M-PFI')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Depositos DECEVAL' AND la_prod_name = 'M-PFI'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PFI.ReporteDepositosDeceval', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-PFI', NULL, NULL, 1 ) 		
END

--INSERCION DE GRUPO DE MODULOS

select @w_id_modulegroup = max(mg_id) from an_module_group

IF NOT EXISTS(SELECT 1 FROM an_module_group WHERE mg_name = 'PFI.Reportes' AND mg_store_name = 'M-PFI')
BEGIN 
	select @w_id_modulegroup = @w_id_modulegroup + 1
	INSERT INTO an_module_group(mg_id, mg_name, mg_version, mg_location, mg_store_name) VALUES ( @w_id_modulegroup, 'PFI.Reportes', '1.0.0', 'Ninguno', 'M-PFI' )  		
END


-- INSERCION DE MODULOS

select @w_id_module = max(mo_id) FROM an_module

-- Segundo Nivel

select @w_id_modulegroup = mg_id FROM an_module_group WHERE mg_name = 'PFI.Reportes' AND mg_store_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'PFI.Reportes')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Reportes' AND la_prod_name = 'M-PFI'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'PFI.Reportes', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END


-- INSERCION DE COMPONENTES

select @w_id_component = max(co_id) from an_component

-- Tercer nivel

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PFI.ReporteErroresBatch' and co_prod_name = 'M-PFI')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PFI.ReporteErroresBatch'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 	
	VALUES ( @w_id_component, @w_id_module, 'PFI.ReporteErroresBatch', 'Report.aspx?ItemPath=/PlazoFijoReportes/RErroresBatch', 'http://'+ @w_ip_port + '/Reports/Pages/', 'I', 'cobis5OnCen=no', 'M-PFI' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PFI.ReporteDepositosBloqueados' and co_prod_name = 'M-PFI')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PFI.ReporteDepositosBloqueados'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 	
	VALUES ( @w_id_component, @w_id_module, 'PFI.ReporteDepositosBloqueados', 'Report.aspx?ItemPath=/PlazoFijoReportes/RBloqueos', 'http://'+ @w_ip_port + '/Reports/Pages/', 'I', 'cobis5OnCen=no', 'M-PFI' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PFI.ReporteProvisionAmortizacion' and co_prod_name = 'M-PFI')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PFI.ReporteProvisionAmortizacion'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 	
	VALUES ( @w_id_component, @w_id_module, 'PFI.ReporteProvisionAmortizacion', 'Report.aspx?ItemPath=/PlazoFijoReportes/RProviAmo', 'http://'+ @w_ip_port + '/Reports/Pages/', 'I', 'cobis5OnCen=no', 'M-PFI' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PFI.ReportePagosAutomaticosInteres' and co_prod_name = 'M-PFI')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PFI.ReportePagosAutomaticosInteres'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 	
	VALUES ( @w_id_component, @w_id_module, 'PFI.ReportePagosAutomaticosInteres', 'Report.aspx?ItemPath=/PlazoFijoReportes/ROrdenesPago', 'http://'+ @w_ip_port + '/Reports/Pages/', 'I', 'cobis5OnCen=no', 'M-PFI' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PFI.ReporteOperacionesMonetarias' and co_prod_name = 'M-PFI')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PFI.ReporteOperacionesMonetarias'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 	
	VALUES ( @w_id_component, @w_id_module, 'PFI.ReporteOperacionesMonetarias', 'Report.aspx?ItemPath=/PlazoFijoReportes/RGMF', 'http://'+ @w_ip_port + '/Reports/Pages/', 'I', 'cobis5OnCen=no', 'M-PFI' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PFI.ReporteDepositosDeceval' and co_prod_name = 'M-PFI')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PFI.ReporteDepositosDeceval'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 	
	VALUES ( @w_id_component, @w_id_module, 'PFI.ReporteDepositosDeceval', 'Report.aspx?ItemPath=/PlazoFijoReportes/RDeceval', 'http://'+ @w_ip_port + '/Reports/Pages/', 'I', 'cobis5OnCen=no', 'M-PFI' )  
END
-- INSERCION DE ZONA

select @w_id_zone = max(zo_id) from an_zone

IF NOT EXISTS(SELECT 1 FROM an_zone WHERE zo_name = 'Zona WEB')
BEGIN 
	select @w_id_zone = @w_id_zone + 1	
	INSERT INTO an_zone (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value ) VALUES ( @w_id_zone, 'Zona WEB', 1, 0, 0, 1 ) 
END

-- INSERCION DE PAGINAS POR ZONA

select @w_id_pagezone = max(pz_id) from an_page_zone
select @w_id_zone = zo_id from an_zone where zo_name = 'Zona WEB'

-- Segundo nivel

-- Tercer nivel

select @w_id_page = pa_id from an_page where pa_name = 'PFI.ReporteErroresBatch' and pa_prod_name = 'M-PFI'
select @w_id_component = co_id from an_component where co_name = 'PFI.ReporteErroresBatch' and co_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Errores Batch' AND la_prod_name = 'M-PFI'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'PFI.ReporteDepositosBloqueados' and pa_prod_name = 'M-PFI'
select @w_id_component = co_id from an_component where co_name = 'PFI.ReporteDepositosBloqueados' and co_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Depositos Bloqueados' AND la_prod_name = 'M-PFI'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'PFI.ReporteProvisionAmortizacion' and pa_prod_name = 'M-PFI'
select @w_id_component = co_id from an_component where co_name = 'PFI.ReporteProvisionAmortizacion' and co_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Provision y Amortizacion' AND la_prod_name = 'M-PFI'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'PFI.ReportePagosAutomaticosInteres' and pa_prod_name = 'M-PFI'
select @w_id_component = co_id from an_component where co_name = 'PFI.ReportePagosAutomaticosInteres' and co_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Pagos Automaticos de Interes' AND la_prod_name = 'M-PFI'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'PFI.ReporteOperacionesMonetarias' and pa_prod_name = 'M-PFI'
select @w_id_component = co_id from an_component where co_name = 'PFI.ReporteOperacionesMonetarias' and co_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Operaciones Monetarias' AND la_prod_name = 'M-PFI'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'PFI.ReporteDepositosDeceval' and pa_prod_name = 'M-PFI'
select @w_id_component = co_id from an_component where co_name = 'PFI.ReporteDepositosDeceval' and co_prod_name = 'M-PFI'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Depositos DECEVAL' AND la_prod_name = 'M-PFI'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END
go

/******AUTORIZACION**********/

declare @w_id_rol int

select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS' 

--Autoriza los modulos

insert into an_role_module(rm_mo_id, rm_rol)
select mo_id,@w_id_rol from an_module where mo_name in ('PFI.Reportes')
	and mo_id not in (select rm_mo_id from an_role_module where rm_rol = @w_id_rol)

--Autoriza los componentes

insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('PFI.ReporteErroresBatch')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)
	
insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('PFI.ReporteDepositosBloqueados')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)

insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('PFI.ReporteProvisionAmortizacion')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)
	
insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('PFI.ReportePagosAutomaticosInteres')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)
	
insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('PFI.ReporteOperacionesMonetarias')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)
	
insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('PFI.ReporteDepositosDeceval')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)
	
--Autoriza las paginas
						
insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('PFI.Reportes','PFI.ReporteErroresBatch')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)

insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('PFI.Reportes','PFI.ReporteDepositosBloqueados')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)

insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('PFI.Reportes','PFI.ReporteProvisionAmortizacion')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)

insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('PFI.Reportes','PFI.ReportePagosAutomaticosInteres')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)
	
insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('PFI.Reportes','PFI.ReporteOperacionesMonetarias')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)
	
insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('PFI.Reportes','PFI.ReporteDepositosDeceval')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)
	
go
