/******************************************************************/
/*                         COBIS CORPORATION                      */
/******************************************************************/
/*  SCRIPT DE CREACION DINAMICA DE BASES DE DATOS PARA PRODUCTOS  */
/*  COBIS                                                         */
/******************************************************************/

use master
go

print 'Creando base de datos para productos COBIS'
go

declare @w_vdevno         int,
        @w_secuencial     int,
        @w_nombre         varchar(30),
        @w_ruta_fisica    varchar(255),
        @w_tamano_data    int,
        @w_tamano_log     int,
        @w_nombre_dat     varchar(100),
        @w_nombre_log     varchar(100),
        @w_nombrel        varchar(30),
        @w_tamano_datakb  int,
        @w_tamano_logkb   int,
        @w_cmd            varchar(255),
        @w_numlibres      int

/*Define cuantas posiciones de dispositivos van a reservarse*/
select @w_numlibres = 1

while 1 = 1 begin
    set rowcount 1
    select @w_secuencial   = secuencial,
           @w_nombre       = nombre,
           @w_ruta_fisica  = ruta_fisica,
           @w_tamano_data  = tamano_data,
           @w_tamano_log   = tamano_log
    from parambd_cobis
    where secuencial >= isnull(@w_secuencial,0)

    if @@rowcount = 0 begin
        break        
    end

    if not exists(select 1 from sysdatabases where name = @w_nombre) begin
        print 'creando  Dispositivos para %1!' + @w_nombre
   
        /*Creando Dispositivos*/

        select @w_vdevno = @w_numlibres + max( convert(tinyint, substring(convert(binary(4), d.low), v.low, 1)))
        from sysdevices d, spt_values v
  
        select @w_nombre_dat    = @w_ruta_fisica + '\' + @w_nombre + '.dat',
               @w_nombre_log    = @w_ruta_fisica + '\' + @w_nombre + '.log',
               @w_tamano_datakb = (@w_tamano_data * 1024)/2,
               @w_tamano_logkb  = (@w_tamano_log  * 1024)/2,
               @w_nombrel       = @w_nombre + '_log'

        select @w_nombre_dat,
               @w_nombre_log,
               @w_tamano_datakb,
               @w_tamano_logkb,
               @w_nombrel

    /*    disk init name = @w_nombre,
        physname = @w_nombre_dat,
--        vdevno = @w_vdevno,
        size = @w_tamano_datakb,
	cntrltype = 0*/


--	sp_deviceattr 'cob_report_dat', dsync, true


    
        select @w_vdevno = @w_numlibres + max( convert(tinyint, substring(convert(binary(4), d.low), v.low, 1)))
        from sysdevices d, spt_values v

/*        physname = @w_nombre_log,
--        vdevno = @w_vdevno,
        size = @w_tamano_logkb,
        cntrltype = 0*/


        print 'creando Base de Datos %1!' + @w_nombre

        select @w_cmd = 'create database ' + @w_nombre + ' on ' + @w_nombre + ' = ' + convert(varchar(10),@w_tamano_data) + ' log on ' + @w_nombrel + ' = ' + convert(varchar(10),@w_tamano_log)

        exec ( @w_cmd )
    end
    else
        print 'Base de Datos %1! ya Existe...'+ @w_nombre

    select @w_secuencial = @w_secuencial + 1
end

print 'Proceso de Creación de base de Datos FInalizado'

go
