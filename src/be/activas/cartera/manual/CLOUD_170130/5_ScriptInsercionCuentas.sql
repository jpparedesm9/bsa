use cob_conta
go

declare 
@w_secuencial    int ,
@w_cuenta        varchar(64),
@w_nombre        varchar(84),
@w_movimiento    varchar(1),
@w_naturaleza    varchar(1),
@w_cuenta_padre  varchar(64),
@w_cuenta_aux    varchar(64),
@w_digitos_sus   varchar(20),
@w_nivel         int,
@w_fecha_proceso datetime

select  @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso



create table #nuevas_cuentas
(secuencial    int ,
 cuenta        varchar(64),
 nombre        varchar(84),
 movimiento    varchar(1),
 naturaleza    varchar(1)
 )
 
 create table #plan_cuentas(
 empresa int         null,
 cuenta  varchar(14) null,
 oficina smallint    null,
 area    smallint    null,
 clave   varchar(30) null
 )

insert into #nuevas_cuentas values(1,'13119006','MICROCRÉDITOS CAPITAL ETAPA 2','N','D')
insert into #nuevas_cuentas values(2,'1311900601','MICROCRÉDITOS CAPITAL NO EXIGIBLE ETAPA 2','N','D')
insert into #nuevas_cuentas values(3,'131190060101','MICROCRÉDITOS CAPITAL GRUPALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(4,'131190060102','MICROCRÉDITOS CAPITAL INDIVIDUAL SIMPLE ETAPA 2','S','D')
insert into #nuevas_cuentas values(5,'131190060103','MICROCRÉDITOS CAPITAL INDIVIDUALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(6,'1311900602','MICROCRÉDITOS CAPITAL EXIGIBLE ETAPA 2','N','D')
insert into #nuevas_cuentas values(7,'131190060201','MICROCRÉDITOS CAPITAL GRUPALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(8,'131190060202','MICROCRÉDITOS CAPITAL INDIVIDUAL SIMPLE ETAPA 2','S','D')
insert into #nuevas_cuentas values(9,'131190060203','MICROCRÉDITOS CAPITAL INDIVIDUALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(10,'13119007','MICROCRÉDITOS INTERÉS ETAPA 2','N','D')
insert into #nuevas_cuentas values(11,'1311900701','INTERESES DEVENGADO NO EXIGIBLE ETAPA 2','N','D')
insert into #nuevas_cuentas values(12,'131190070101','MICROCRÉDITOS INTERESES GRUPALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(13,'131190070102','MICROCRÉDITOS INTERESES INDIVIDUAL SIMPLE ETAPA 2','S','D')
insert into #nuevas_cuentas values(14,'131190070103','MICROCRÉDITOS INTERESES INDIVIDUALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(15,'1311900702','INTERESES DEVENGADO EXIGIBLE ETAPA 2','N','D')
insert into #nuevas_cuentas values(16,'131190070201','MICROCRÉDITOS INTERESES GRUPALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(17,'131190070202','MICROCRÉDITOS INTERESES INDIVIDUAL SIMPLE ETAPA 2','S','D')
insert into #nuevas_cuentas values(18,'131190070203','MICROCRÉDITOS INTERESES INDIVIDUALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(19,'139150619022','CARTERA CON RIESGO DE CREDITO MICROCRÉDITOS  GRUPALES ETAPA 1','S','D')
insert into #nuevas_cuentas values(20,'139150619023','CARTERA CON RIESGO DE CREDITO MICROCRÉDITOS  INDIVIDUAL SIMPLE ETAPA 1','S','D')
insert into #nuevas_cuentas values(21,'139150619024','CARTRA CON RIESGO DE CREDITO MICROCRÉDITOS  INDIVIDUALES ETAPA 1','S','D')
insert into #nuevas_cuentas values(22,'139150619025','CARTERA CON RIESGO DE CREDITO MICROCRÉDITOS  GRUPALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(23,'139150619026','CARTERA CON RIESGO DE CREDITO MICROCRÉDITOS  INDIVIDUAL SIMPLE ETAPA 2','S','D')
insert into #nuevas_cuentas values(24,'139150619027','CARTRA CON RIESGO DE CREDITO MICROCRÉDITOS  INDIVIDUALES ETAPA 2','S','D')
insert into #nuevas_cuentas values(25,'139150619028','CARTERA CON RIESGO DE CREDITO MICROCRÉDITOS  GRUPALES ETAPA 3','S','D')
insert into #nuevas_cuentas values(26,'139150619029','CARTERA CON RIESGO DE CREDITO MICROCRÉDITOS  INDIVIDUAL SIMPLE ETAPA 3','S','D')
insert into #nuevas_cuentas values(27,'139150619030','CARTRA CON RIESGO DE CREDITO MICROCRÉDITOS  INDIVIDUALES ETAPA 3','S','D')
insert into #nuevas_cuentas values(28,'5105119003','MICROCRÉDITOS INTERESES GRAVADOS (DEVENGADOS EXIGIBLES) ETAPA 2','N','D')
insert into #nuevas_cuentas values(29,'510511900301','MICROCRÉDITOS GRUPAL INT. ETAPA 2','S','D')
insert into #nuevas_cuentas values(30,'510511900302','MICROCRÉDITOS INDIVIDUAL SIMPLE  INT. ETAPA 2','S','D')
insert into #nuevas_cuentas values(31,'510511900303','MICROCRÉDITOS INDIVIDUAL  INT. ETAPA 2','S','D')
insert into #nuevas_cuentas values(32,'5105119004','MICROCRÉDITOS INTERESES GRAVADOS (DEVENGADOS NO EXIGIBLES) ETAPA 2','N','D')
insert into #nuevas_cuentas values(33,'510511900401','MICROCRÉDITOS GRUPAL INT. ETAPA 2','S','D')
insert into #nuevas_cuentas values(34,'510511900402','MICROCRÉDITOS INDIVIDUAL SIMPLE  INT. ETAPA 2','S','D')
insert into #nuevas_cuentas values(35,'510511900403','MICROCRÉDITOS INDIVIDUAL  INT. ETAPA 2','S','D')
insert into #nuevas_cuentas values(36,'629101619023','GRADO DE RIESGO MICROCRÉDITOS  GRUPALES ETAPA 1','S','C')
insert into #nuevas_cuentas values(37,'629101619024','GRADO DE RIESGO MICROCRÉDITOS  INDIVIDUAL SIMPLE ETAPA 1','S','C')
insert into #nuevas_cuentas values(38,'629101619025','GRADO DE RIESGO MICROCRÉDITOS  INDIVIDUALES ETAPA 1','S','C')
insert into #nuevas_cuentas values(39,'629101619026','GRADO DE RIESGO MICROCRÉDITOS  GRUPALES ETAPA 2','S','C')
insert into #nuevas_cuentas values(40,'629101619027','GRADO DE RIESGO MICROCRÉDITOS  INDIVIDUAL SIMPLE ETAPA 2','S','C')
insert into #nuevas_cuentas values(41,'629101619028','GRADO DE RIESGO MICROCRÉDITOS  INDIVIDUALES ETAPA 2','S','C')
insert into #nuevas_cuentas values(42,'629101619029','GRADO DE RIESGO MICROCRÉDITOS  GRUPALES ETAPA 3','S','C')
insert into #nuevas_cuentas values(43,'629101619030','GRADO DE RIESGO MICROCRÉDITOS  INDIVIDUAL SIMPLE ETAPA 3','S','C')
insert into #nuevas_cuentas values(44,'629101619031','GRADO DE RIESGO MICROCRÉDITOS  INDIVIDUALES ETAPA 3','S','C')


select @w_secuencial = 0

while 1 = 1
begin
   select top 1
   @w_secuencial    = secuencial,
   @w_cuenta        = ltrim(rtrim(cuenta)),
   @w_nombre        = nombre,
   @w_movimiento    = ltrim(rtrim(movimiento)),
   @w_naturaleza    = ltrim(rtrim(naturaleza))
   from #nuevas_cuentas
   where secuencial > @w_secuencial
   order by secuencial
     
   if @@rowcount = 0 break
   
   if not exists(select 1 from cb_cuenta where cu_cuenta = ltrim(rtrim(@w_cuenta)))
   begin
        select @w_cuenta_aux = ''
        select @w_digitos_sus = substring(@w_cuenta,len(@w_cuenta),1)       
        select @w_cuenta_aux = substring(@w_cuenta,1,len(@w_cuenta)-1)
        
        while not exists(select 1 from cb_cuenta where cu_cuenta = ltrim(rtrim(@w_cuenta_aux))) 
        begin
           select @w_digitos_sus = substring(@w_cuenta_aux,len(@w_cuenta_aux),1) +'' + @w_digitos_sus
           select @w_cuenta_aux = substring(@w_cuenta_aux,1,len(@w_cuenta_aux)-1)              
        end
        
        select 
        '@w_cuenta'= @w_cuenta,
        '@w_cuenta_padre'= @w_cuenta_aux,
        '@w_digitos_sus'= @w_digitos_sus
        
        select 
        @w_cuenta= @w_cuenta,
        @w_cuenta_padre= @w_cuenta_aux
        
        if exists (select 1 from cb_cuenta where cu_cuenta = ltrim(rtrim(@w_cuenta_padre)))
        begin
           select @w_nivel = null
           
           select @w_nivel =  cu_nivel_cuenta
           from cb_cuenta 
           where cu_cuenta = ltrim(rtrim(@w_cuenta_padre))
           
           if @w_nivel is null 
              print 'No existe nivel cuenta '
           
           if @w_nivel is not null
           begin
              select @w_nivel = @w_nivel + 1
              select @w_nivel
              insert into cb_cuenta (
                      cu_empresa   , cu_cuenta      , cu_cuenta_padre, cu_nombre       , cu_descripcion, cu_estado  , 
                      cu_movimiento, cu_nivel_cuenta, cu_categoria   , cu_fecha_estado , cu_moneda     , cu_sinonimo, 
                      cu_acceso    , cu_presupuesto )                                                                 
              values (1            , @w_cuenta      , @w_cuenta_padre, @w_nombre       , @w_nombre     , 'V'        , 
                      @w_movimiento, @w_nivel       , @w_naturaleza  , @w_fecha_proceso, 0             , NULL       , 
                      NULL         , NULL)
           end
        end 
       
        if not exists(select 1 from cb_cuenta where cu_cuenta = ltrim(rtrim(@w_cuenta_padre)))
          print 'No existe cuenta: ' + @w_cuenta_padre
          
          
       --Insercion plan de cuentas
       if @w_movimiento = 'S'
       begin
          
          truncate table #plan_cuentas
          
          insert into #plan_cuentas(
          empresa ,  cuenta,  oficina,
          area    ,  clave )
          select distinct 
          pg_empresa,
          @w_cuenta ,
          pg_oficina,
          pg_area   ,   
          null       
          from cob_conta..cb_plan_general
          
          update #plan_cuentas set
          clave = convert(varchar, empresa) + convert(varchar, cuenta)+ convert(varchar, oficina) +convert(varchar, area) 
          
          insert into cob_conta..cb_plan_general
          select * 
          from #plan_cuentas
          where not exists(select 1 from cob_conta..cb_plan_general where pg_oficina = oficina and pg_cuenta = cuenta)
       
       end  
         
   end 
   
end 


select * into #cb_cuenta_proceso_dos from cb_cuenta_proceso where 1 =2


insert into #cb_cuenta_proceso_dos 
select 
cp_proceso = (case cu_movimiento when 'N' then 36411 else 6003 end),
cp_empresa = 1,
cp_cuenta  = cu_cuenta ,
cp_oficina = 0,
cp_area    = 0,
cp_imprima = '0',
cp_condicion = '1',
cp_texto = 'ETAPA2',
cp_quiebre = null
from cb_cuenta 
where  cu_cuenta in (select cuenta from #nuevas_cuentas)
and not exists(select 1 from cb_cuenta_proceso where cp_cuenta = cu_cuenta)


insert into #cb_cuenta_proceso_dos 
select 
cp_proceso = (case cu_movimiento when 'N' then 36411 else 6003 end),
cp_empresa = 1,
cp_cuenta  = cu_cuenta ,
cp_oficina = 0,
cp_area    = 0,
cp_imprima = '0',
cp_condicion = '1',
cp_texto = 'ETAPA2',
cp_quiebre = null
from cb_cuenta 
where  cu_nombre like '%ETAPA 2%'
and not exists(select 1 from cb_cuenta_proceso where cp_cuenta = cu_cuenta)
and not exists(select 1 from #cb_cuenta_proceso_dos  where cp_cuenta = cu_cuenta)


insert into cb_cuenta_proceso 
select * from #cb_cuenta_proceso_dos 


drop table #cb_cuenta_proceso_dos 
drop table #nuevas_cuentas
drop table #plan_cuentas