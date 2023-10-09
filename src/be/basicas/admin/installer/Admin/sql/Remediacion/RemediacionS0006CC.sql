/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */

use cobis
go

if exists (select * from sysobjects
           where type='V' and name='ts_conexion_login') 
DROP VIEW ts_conexion_login
go

CREATE VIEW ts_conexion_login (
   usuario, terminal, id_oficina,nombre_oficina,
   nombre_usuario, id_cargo, nombre_cargo, 
   fecha, autenticacion, id_estado_usuario , 
   desc_estado_usuario ,observacion, secuencia
)
as
select ts.ts_user, ts.ts_term,ts.ts_oficina, e.of_nombre,
    f.fu_nombre, f.fu_cargo ,'descp_cargo'=c.valor,
    ts.ts_fecha, 'autenticacion'= ts.ts_char, u.us_estado, 
        'descp_estado'=(
          case u.us_estado
          when 'V' then ('ACTIVO')
          when 'B' then ('BLOQUEADO')
          else ('')
           end )
     ,  'observacion'=ts.ts_desc_larga , ts.ts_secuencia from cobis..ad_tran_servicio ts
inner join cobis..cl_funcionario f on f.fu_login = ts.ts_user
LEFT join cobis..cl_tabla d ON d.tabla = 'cl_cargo' 
LEFT join cobis..cl_catalogo c ON convert(varchar(10) , f.fu_cargo ) = c.codigo and d.codigo=c.tabla
LEFT join cobis..cl_oficina e on e.of_oficina = ts.ts_oficina
inner join cobis..ad_usuario u  on u.us_login = ts.ts_user and  us_oficina =  ts.ts_oficina
where  ts_tipo_transaccion = 554

go

if exists (select 1 from ad_procedure where  pd_procedure = 5221)
   delete from ad_procedure where  pd_procedure = 5221
go


insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5221,'sp_cons_conex_login','cobis','V',getdate(),'conlogin.sp')
go


if exists (select 1 from cl_ttransaccion where tn_trn_code = 15417 and tn_nemonico = 'COTRSE' )
   delete cl_ttransaccion where tn_trn_code = 15417 and tn_nemonico = 'COTRSE'
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15417, 'CONSULTA CONEXIONES DESDE TRANSACCION DE SERVICIO', 'COTRSE', 'CONSULTA CONEXIONES DESDE TRANSACCION DE SERVICIO')
go


if exists (select 1 from ad_pro_transaccion where  pt_producto = 1 and pt_transaccion = 15417 )
   delete  from ad_pro_transaccion where  pt_producto = 1 and pt_transaccion = 15417 
go

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (1, 'R', 0, 15417, 'V', getdate(), 5221, null) 


if exists (select 1 from ad_tr_autorizada where ta_transaccion = 15417 and  ta_producto = 1 )
   delete  ad_tr_autorizada where ta_transaccion = 15417 and  ta_producto = 1
   
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
values (1,'R',0,15417,3,getdate(),1,'V',getdate())

go


use cobis
go


-----------------------------------------------------------------------------------------------
-- Eliminación de pagina a partir de pa_name
-----------------------------------------------------------------------------------------------
declare @w_pa_name varchar(100),
    @w_pa_id_label integer,
    @w_cod_label integer,
    @w_label varchar(100),
    @w_cod_page integer,
    @w_cod_component integer

select @w_pa_name = 'AS.ADMSEG.FConexFallidaClass'
--borra label
select @w_pa_id_label = pa_la_id from an_page where pa_name = @w_pa_name
delete from an_label where la_id = @w_pa_id_label and la_prod_name = 'M-ADM.Seg'
--borra page
select @w_cod_page = pa_id from an_page where pa_name = @w_pa_name
delete from an_page where pa_id = @w_cod_page
delete from an_role_page where rp_pa_id = @w_cod_page
--borra page_zone
select @w_cod_component = pz_co_id from an_page_zone  where pz_pa_id = @w_cod_page
delete from an_page_zone where pz_pa_id = @w_cod_page
--borra component
delete from an_component where co_id = @w_cod_component
delete from an_role_component where rc_co_id = @w_cod_component

go


-- Registros para: PI.CCA.FOperacion    


declare @w_la_label varchar(255),@w_prod_name varchar(20),@w_rol_des varchar(255),@w_pa_parent varchar(255),@w_pa_name varchar(255),@w_orden int,@w_mo_name varchar(255),@w_co_name varchar(255),@w_co_class varchar(255),@w_co_namespace varchar(255)
select  @w_la_label     = 'Consulta de Conexiones Fallidas',
        @w_prod_name    = 'M-ADM.Seg',
        @w_rol_des      = 'MENU POR PROCESOS',
        @w_pa_parent    = 'AS.Consultas3',
        @w_pa_name      = 'AS.ADMSEG.FConexFallidaClass',
        @w_orden        = 12,
        @w_mo_name      = 'ADMSEG.Query',
        @w_co_name      = 'ADMSEG.FConexFallida',
        @w_co_class     = 'FConexFallidaClass',
        @w_co_namespace = 'COBISCorp.tCOBIS.ADMSEG.Query'
        
print 'Registros de Opción de MENU: ' + @w_la_label
if not exists (select 1 from cobis..an_page where pa_name = @w_pa_name)
begin
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int, @wd_parent_module int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = @w_rol_des
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label values (@w_la_id, @w_la_cod, @w_la_label, @w_prod_name)
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = @w_pa_parent
    insert into cobis..an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id)
    values (@w_pa_id, @w_la_id, @w_pa_name, 'icono pagina', @w_pa_id_parent, @w_orden, 'horizontal', 'Nemonic', @w_prod_name, '', null)
    insert into cobis..an_role_page values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone values (1, 'Zona 1', 1, 1, 1, 1)  end
    select @w_mo_id = mo_id from cobis..an_module where mo_name = @w_mo_name

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module values (@w_mo_id, @w_rol)
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component values (@w_co_id, @w_mo_id, @w_co_name, @w_co_class, @w_co_namespace, 'SV', '', @w_prod_name)
    insert into cobis..an_role_component values (@w_co_id, @w_rol)

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1

    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
        insert into cobis..an_page_zone values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go


-----------------------------------------------------------------------------------------------------------------------------------------------

declare @w_co_id        int,
          @w_prod_name  varchar(10),
          @w_co_mo_id   int,
          @w_la_id      int,
          @w_sco_id     int,
          @w_la_cod     varchar(10)
          

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
       
select @w_co_id = co_id from an_component where co_class = 'FConexFallidaClass' and co_prod_name = @w_prod_name
   
delete cobis..an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15404)  
insert into cobis..an_transaction_component values (@w_co_id,15404,null)
go

