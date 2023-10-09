use cobis
go

set nocount on
go

if not exists(select 1 from cl_seqnos where bdatos='cobis' and tabla='ba_log_operador')
    insert into cl_seqnos values ('cobis', 'ba_log_operador', 0, 'lo_sec')
go

-----------------------------------------------
/*CREACION DE ROL DE OPERADOR DE BATCH COBIS */
-----------------------------------------------

declare @w_rol smallint

select @w_rol = null

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'OPERADOR DE BATCH COBIS'
   and ro_filial      = 1

if @w_rol is null
begin       --CREAR EL ROL
    select @w_rol = pa_tinyint
      from cl_parametro
    where pa_nemonico = 'ROB'

    if @w_rol is null
    begin
        select @w_rol = max(ro_rol) + 1 
          from ad_rol

        insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado,
                                   ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'OPERADOR DE BATCH COBIS', getdate(), 1, 'V', getdate(), null)

        update cl_seqnos
           set siguiente = @w_rol
         where tabla  = 'ad_rol'
           and bdatos = 'cobis'       

        delete cl_parametro
          where pa_nemonico = 'ROB'
            and pa_producto = 'ADM'              

        insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
        values ('ROB', 'ROL DE OPERADOR DE BATCH UNIX', 'T',@w_rol , 'ADM')
    end
    else
        insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado,
                                   ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'OPERADOR DE BATCH COBIS', getdate(), 1, 'V', getdate(), null)

end

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'OPERADOR DE BATCH COBIS'
   and ro_filial      = 1


if exists (select 1 from ad_tr_autorizada where ta_rol = @w_rol)
    delete ad_tr_autorizada where ta_rol = @w_rol

/* Ingreso de transacciones autorizadas para conexion y desconexion */   
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 568, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1502, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1504, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1571, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 1577, @w_rol, getdate(), 1, 'V', getdate())  --ya se ingresa mas abajo
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1594, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15030, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 15031, @w_rol, getdate(), 1, 'V', getdate())   --se ingresa mas abajo
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15037, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15098, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15222, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15294, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8001, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8002, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8003, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8004, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8005, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8006, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8007, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8008, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8014, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8015, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8016, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8017, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8027, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8031, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8032, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8033, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8035, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8045, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (8, 'R', 0, 8061, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8062, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8063, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8065, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8067, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8068, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values (8, 'R', 0, 8069, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values (8, 'R', 0, 8070, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8071, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8073, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8074, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8081, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8082, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8083, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8085, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8088, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8089, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8090, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8091, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8092, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8093, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8094, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8095, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8096, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8097, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8098, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8099, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8100, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8101, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8102, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8103, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8104, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8105, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8106, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8107, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8108, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8109, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8110, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8113, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8114, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8201, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8202, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8203, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8204, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8205, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 15289, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 15291, @w_rol, getdate(), 1, 'V', getdate())

/* Transacciones BASICAS DE CEN*/
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1564,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1574,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1577,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1579,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15001,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15031,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15153,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15168,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15302,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15301,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15315,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15316,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15317,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15318,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15319,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15320,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15913,@w_rol,getdate(),1,'V',getdate())
go	


----------------------------------------------
/*CREACION DE ROL DE SUPERVISOR BATCH COBIS */
----------------------------------------------

if not exists(select 1 from cl_seqnos where bdatos='cobis' and tabla='ba_log_supervisor')
    insert into cl_seqnos values ('cobis', 'ba_log_supervisor', 0, 'lo_sec')
go


declare @w_rol smallint
select @w_rol = null

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'SUPERVISOR DE BATCH COBIS'
   and ro_filial      = 1

if @w_rol is null
begin       --CREAR EL ROL
    select @w_rol = pa_tinyint
      from cl_parametro
    where pa_nemonico = 'SOB'

    if @w_rol is null
    begin
        select @w_rol = max(ro_rol) + 1 
          from ad_rol

        insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado,
                                   ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'SUPERVISOR DE BATCH COBIS', getdate(), 1, 'V', getdate(), null)

        update cl_seqnos
           set siguiente = @w_rol
         where tabla  = 'ad_rol'
           and bdatos = 'cobis'       

        delete cl_parametro
          where pa_nemonico = 'SOB'
            and pa_producto = 'ADM'

        insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
        values ('SOB', 'SUPERVISOR DE BATCH COBIS', 'T',@w_rol , 'ADM')
    end
    else
        insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado,
                                   ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'SUPERVISOR DE BATCH COBIS', getdate(), 1, 'V', getdate(), null)

end

if exists (select 1 from ad_tr_autorizada where ta_rol = @w_rol)
    delete ad_tr_autorizada where ta_rol = @w_rol

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8007, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8014, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8017, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8027, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8061, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8062, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8063, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8065, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8067, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8068, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8111, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8112, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8114, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8118, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 568, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 1574, @w_rol, getdate(), 1, 'V', getdate())   --se ingresa mas abajo
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 1577, @w_rol, getdate(), 1, 'V', getdate())  --se ingresa mas abajo
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1502, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15030, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 15031, @w_rol, getdate(), 1, 'V', getdate())   --se ingresa mas abajo
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15037, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15098, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15222, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15289, @w_rol, getdate(), 1, 'V', getdate())

/* Transacciones BASICAS DE CEN*/
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1564,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1574,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1577,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1579,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15001,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15031,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15153,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15168,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15302,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15301,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15315,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15316,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15317,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15318,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15319,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15320,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15913,@w_rol,getdate(),1,'V',getdate())
go	



--------------------------------------------------------
/* CREACION DE R0L LECTURA DE REPORTES DE BATCH COBIS */
--------------------------------------------------------

if not exists(select 1 from cl_seqnos where bdatos='cobis' and tabla='ba_log_lectura')
    insert into cl_seqnos values ('cobis', 'ba_log_lectura', 0, 'lo_sec')
go

declare @w_rol smallint
select @w_rol = null

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'LECTURA DE REPORTES DE BATCH COBIS'
   and ro_filial      = 1

if @w_rol is null
begin       --CREAR EL ROL
    select @w_rol = pa_tinyint
      from cl_parametro
    where pa_nemonico = 'LOB'

    if @w_rol is null
    begin
        select @w_rol = max(ro_rol) + 1 
          from ad_rol

        insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado,
                                   ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'LECTURA DE REPORTES DE BATCH COBIS', getdate(), 1, 'V', getdate(), null)

        update cl_seqnos
           set siguiente = @w_rol
         where tabla  = 'ad_rol'
           and bdatos = 'cobis'       

        delete cl_parametro
          where pa_nemonico = 'LOB'
            and pa_producto = 'ADM'              

        insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
        values ('LOB', 'LECTURA DE REPORTES DE BATCH COBIS', 'T',@w_rol , 'ADM')
    end
    else
        insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado,
                                   ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'LECTURA DE REPORTES DE BATCH COBIS', getdate(), 1, 'V', getdate(), null)
end

if exists (select 1 from ad_tr_autorizada where ta_rol = @w_rol)
    delete ad_tr_autorizada where ta_rol = @w_rol

/* Ingreso de transacciones autorizadas para conexion y desconexion */   
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 568, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1502, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1504, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1571, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 1577, @w_rol, getdate(), 1, 'V', getdate())    --se ingresa mas abajo
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 1594, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15289, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15030, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
--values (1, 'R', 0, 15031, @w_rol, getdate(), 1, 'V', getdate())   --se ingresa mas abajo
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15037, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15098, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15222, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', 0, 15294, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8073, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8074, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8008, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (8, 'R', 0, 8110, @w_rol, getdate(), 1, 'V', getdate())

/* Transacciones BASICAS DE CEN*/
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1564,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1574,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1577,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,1579,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15001,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15031,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15153,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15168,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15302,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15301,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15315,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15316,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15317,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15318,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15319,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15320,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(1,'R',0,15913,@w_rol,getdate(),1,'V',getdate())
go	



/* TRN VISUAL BATCH EN ROL MENU POR PROCESOS */

declare @w_rol smallint
select @w_rol = null

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'
   and ro_filial      = 1

if @w_rol is not null
begin       

	/* Ingreso de transacciones autorizadas para conexion y desconexion */   
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 568 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 568, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1502 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 1502, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1504 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 1504, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1571 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 1571, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1577 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 1577, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1594 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 1594, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15030 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 15030, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15031 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 15031, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15037 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 15037, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15098 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 15098, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15222 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 15222, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15294 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (1, 'R', 0, 15294, @w_rol, getdate(), 1, 'V', getdate())

	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8001 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8001, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8002 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8002, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8003 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8003, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8004 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8004, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8005 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8005, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8006 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8006, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8007 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8007, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8008 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8008, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8014 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8014, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8015 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8015, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8016 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8016, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8017 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8017, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8027 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8027, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8031 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8031, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8032 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8032, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8033 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8033, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8035 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8035, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8045 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8045, @w_rol, getdate(), 1, 'V', getdate())
		--insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		--values (8, 'R', 0, 8061, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8062 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8062, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8063 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8063, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8065 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8065, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8067 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8067, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8068 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8068, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8069 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
		values (8, 'R', 0, 8069, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8070 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
		values (8, 'R', 0, 8070, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8071 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8071, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8073 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8073, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8074 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8074, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8081 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8081, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8082 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8082, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8083 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8083, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8085 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8085, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8088 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8088, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8089 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8089, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8090 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8090, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8091 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8091, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8092 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8092, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8093 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8093, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8094 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8094, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8095 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8095, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8096 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8096, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8097 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8097, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8098 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8098, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8099 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8099, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8100 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8100, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8101 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8101, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8102 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8102, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8103 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8103, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8104 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8104, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8105 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8105, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8106 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8106, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8107 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8107, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8108 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8108, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8109 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8109, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8110 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8110, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8113 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8113, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8114 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8114, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8201 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8201, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8202 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8202, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8203 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8203, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8204 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8204, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 8205 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 8205, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15289 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 15289, @w_rol, getdate(), 1, 'V', getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15291 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values (8, 'R', 0, 15291, @w_rol, getdate(), 1, 'V', getdate())
		
	/* Transacciones BASICAS DE CEN*/
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1564 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,1564,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1574 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,1574,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1577 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,1577,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1579 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,1579,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15001 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15001,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15031 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15031,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15153 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15153,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15168 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15168,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15302 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15302,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15301 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15301,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15315 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15315,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15316 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15316,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15317 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15317,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15318 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15318,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15319 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15319,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15320 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15320,@w_rol,getdate(),1,'V',getdate())
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15913 and ta_rol = @w_rol)
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
		values(1,'R',0,15913,@w_rol,getdate(),1,'V',getdate())

end

go
