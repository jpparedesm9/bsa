use cobis
go

set nocount on
go
/****************************************************************/
/* AUTORIZACION DE TRXS AL ROL MENU POR PROCESOS DE PERSONALIZACION */
/****************************************************************/
print 'Autorizaci¢n de transacciones al rol MENU POR PROCESOS DE PERSONALIZACION'
declare @w_rol  int
select  @w_rol = ro_rol
  from  ad_rol
 where  ro_descripcion like 'MENU POR PROCESOS'

if @@rowcount = 0
   begin
      print 'CREANDO ROL'
      select * from cobis..cl_seqnos where tabla = 'ad_rol'

      select @w_rol = max(ro_rol) + 1 from ad_rol

     select  *
      into    #ad_rol_tmp
      from    ad_rol
     where   ro_descripcion = 'MENU POR PROCESOS'

     update  #ad_rol_tmp set ro_rol = @w_rol, ro_descripcion = 'MENU POR PROCESOS'

     insert into ad_rol
     select * from #ad_rol_tmp

   update cobis..cl_seqnos set siguiente = @w_rol where tabla = 'ad_rol'   
end



delete ad_tr_autorizada
 where ta_producto =17
   and ta_rol = @w_rol

insert into ad_tr_autorizada values(17,'R',0,4000,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4001,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4002,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4003,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4004,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4005,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4006,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4007,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4008,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4009,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4010,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4011,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4012,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4013,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4014,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4015,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4016,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4017,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4018,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4019,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4020,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4021,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4022,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4023,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4024,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4025,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4026,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4027,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4028,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4029,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4030,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4031,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4032,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4033,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4034,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4035,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4036,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4037,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4038,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4039,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4040,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4041,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4042,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4043,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4044,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4045,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4046,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4047,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4048,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4049,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4050,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4051,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4052,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4053,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4054,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4055,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4056,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4057,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4058,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4059,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4060,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4061,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4062,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4063,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4064,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4065,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4066,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4067,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4068,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4069,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4070,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4071,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4072,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4073,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4074,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4075,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4076,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4077,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4078,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4079,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4080,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4081,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4082,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4083,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4084,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4085,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4086,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4087,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4088,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4089,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4090,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4091,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4092,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4093,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4094,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4095,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4096,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4097,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4098,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4099,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4100,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4101,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4102,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4103,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4104,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4105,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4106,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4107,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4108,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4109,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4110,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4111,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4112,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4113,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4114,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4115,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4116,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4117,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4118,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4119,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4120,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4121,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4122,@w_rol,getdate(),1832,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4123,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4124,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4125,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4126,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4127,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4128,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4129,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4136,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4137,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4138,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4139,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4140,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4143,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4156,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4157,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4158,@w_rol,getdate(),3,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,4159,@w_rol,getdate(),3,'V',getdate())

insert into ad_tr_autorizada values(17,'R',0,728,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,729,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,730,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,731,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,424,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,15222,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,28744,@w_rol,getdate(),1,'V',getdate())

insert into ad_tr_autorizada values(17,'R',0,425,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(17,'R',0,426,@w_rol,getdate(),1,'V',getdate())
INSERT INTO ad_tr_autorizada values(17,'R',0,2946,@w_rol,getdate(),1, 'V',getdate())

delete ad_tr_autorizada
 where ta_producto = 2
  and ta_transaccion in (1182,1190,1318)
   and ta_rol = @w_rol



--SECCION DE TRANSACCIONES AUTORIZADAS DE OTROS MODULOS  
-- CLIENTES
insert into ad_tr_autorizada values(2,'R',0,1182,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(2,'R',0,1190,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(2,'R',0,1318,@w_rol,getdate(),1,'V',getdate())



delete ad_tr_autorizada
 where ta_producto = 1
  and ta_transaccion in (
   1502,   1571   ,1577   ,15001,
   15031,  15062  ,15098  ,15103,
   15153,  15168  ,15093  ,15150,
   15151,  15155  ,15156  ,15222,
   28744
  )
   and ta_rol = @w_rol

-- ADMINISTRACION
insert into ad_tr_autorizada values(1,'R',0,1502, @w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,1571,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,1577,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,15001,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,15031,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15062,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,15098,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15103,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,15153,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15168,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,15093,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15150,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',0,15151,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15155,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15156,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,15222,@w_rol,getdate(),1,'V',getdate()) 
insert into ad_tr_autorizada values(1,'R',0,28744,@w_rol,getdate(),1,'V',getdate()) 

delete ad_tr_autorizada
 where ta_producto = 10
  and ta_transaccion in (
   732
  )
   and ta_rol = @w_rol
insert into ad_tr_autorizada values(10,'R',0,732, @w_rol,getdate(),1,'V',getdate())

go

