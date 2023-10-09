use cob_workflow
go


if exists( select 1 from sysindexes where name = 'wf_log_index')
   drop index  wf_paso_automatico_log.wf_log_index 
go

if exists( select 1 from sysindexes where name = 'sch_nombre_actividad_index')
   drop index  wf_scheduler_act.sch_nombre_actividad_index 
go

if exists( select 1 from sysindexes where name = 'sch_estado_activida_index')
   drop index  wf_scheduler_act.sch_estado_activida_index 
go

if exists (select 1
           from  sysobjects
           where id = object_id('wf_scheduler_conf')
             and type = 'U')
   drop table wf_scheduler_conf
go

if exists (select 1
           from  sysobjects
           where id = object_id('wf_scheduler_job')
             and type = 'U')
   drop table wf_scheduler_job 
go

if exists (select 1
           from  sysobjects
           where id = object_id('wf_paso_automatico_log')
             and type = 'U')
   drop table wf_paso_automatico_log
go

if exists (select 1
           from  sysobjects
           where id = object_id('wf_scheduler_act')
             and type = 'U')
   drop table wf_scheduler_act
go

create table wf_scheduler_job ( 
   sj_id_job             int           NOT NULL,
   sj_name               varchar(10)   NOT NULL,
   sj_cron_exp           varchar(64)   NOT NULL,
   sj_job_class          varchar(255)  NOT NULL,
   sj_reload_conf_time   int           NULL,
   CONSTRAINT PK_SCHEDULER_JOB PRIMARY KEY(sj_id_job, sj_name)
)   
-- LOCK DATAROWS
go

create table wf_scheduler_conf ( 
   sj_id_job             int           NOT NULL,
   sj_name               varchar(10)   NOT NULL,
   sc_id_conf            int           NOT NULL,
   sc_name               varchar(64)   NOT NULL,
   sc_value              varchar(255)  NOT NULL,
   CONSTRAINT PK_SCHEDULER_CONF PRIMARY KEY(sc_id_conf)
)
-- LOCK DATAROWS
go

create table wf_paso_automatico_log ( 
   pa_id_inst_proc      int            NOT NULL,
   pa_id_inst_act       int            NOT NULL,
   pa_id_error          int            NOT NULL,
   pa_desc_error        varchar(132)   NOT NULL,
   pa_fecha             datetime NOT   NULL 
)
-- LOCK DATAROWS
go

create table wf_scheduler_act ( 
   sa_id                int            identity,
   sa_codigo_act        int            NOT NULL,
   sa_id_ins_proc       int            NULL,
   sa_estado_eje        char(3)        NOT NULL,
   sa_fecha_ult_mod     datetime       NULL,
   CONSTRAINT PK_SCHEDULER_ACT PRIMARY KEY(sa_id)
)
-- LOCK DATAROWS
go

ALTER TABLE wf_scheduler_conf
   ADD CONSTRAINT FK_SCHEDULER_CONF
   FOREIGN KEY(sj_id_job, sj_name)
   REFERENCES wf_scheduler_job(sj_id_job, sj_name)
go


create index sch_estado_activida_index on 
	wf_scheduler_act (sa_estado_eje, sa_codigo_act)
go

create index wf_log_index on 
	wf_paso_automatico_log (pa_id_inst_proc, pa_id_inst_act, pa_fecha)
go
create index sch_nombre_actividad_index on 
	wf_scheduler_act ( sa_codigo_act)
go

declare @w_id_job  int,
        @w_id_conf int

select @w_id_job = isnull(max(sj_id_job),0) + 1 
from cob_workflow..wf_scheduler_job

select @w_id_conf = isnull(max(sc_id_conf),0) + 1 
from cob_workflow..wf_scheduler_conf

-- JOB ICR_ALL
insert into cob_workflow..wf_scheduler_job (sj_id_job, sj_name, sj_cron_exp, sj_job_class, sj_reload_conf_time) 
                                    values (@w_id_job, 'ICR_ALL', '0 0 0 * * ?',  'com.cobiscorp.ecobis.schedulerapp.jobs.ICRJobManager',  3600000)
-- CONFIG ICR_ALL
insert into cob_workflow..wf_scheduler_conf (sj_id_job, sj_name, sc_id_conf, sc_name, sc_value) 
                                    values  (@w_id_job, 'ICR_ALL', @w_id_conf, 'ICR_URL_SERVICE',  'http://[host]:[port]/SchedulerWS/SrvProcessInstanceWSService/SrvProcessInstanceWSService.wsdl')

select @w_id_conf = @w_id_conf + 1 

insert into cob_workflow..wf_scheduler_conf (sj_id_job, sj_name, sc_id_conf, sc_name, sc_value) 
                                    values  (@w_id_job, 'ICR_ALL', @w_id_conf, 'JOB_TYPE', 'T')

select @w_id_job  = @w_id_job + 1, 
       @w_id_conf = @w_id_conf + 1 


-- JOB ICR_SPEC
insert into cob_workflow..wf_scheduler_job (sj_id_job, sj_name, sj_cron_exp, sj_job_class, sj_reload_conf_time) 
                                    values (@w_id_job, 'ICR_SPEC', '0 0/3 * * * ?',  'com.cobiscorp.ecobis.schedulerapp.jobs.ICRJobManager',  3600000)
-- CONFIG ICR_SPEC
insert into cob_workflow..wf_scheduler_conf (sj_id_job, sj_name, sc_id_conf, sc_name, sc_value) 
                                    values  (@w_id_job, 'ICR_SPEC', @w_id_conf, 'ICR_URL_SERVICE',  'http://[host]:[port]/SchedulerWS/SrvProcessInstanceWSService/SrvProcessInstanceWSService.wsdl')

select @w_id_conf = @w_id_conf + 1 

insert into cob_workflow..wf_scheduler_conf (sj_id_job, sj_name, sc_id_conf, sc_name, sc_value) 
                                    values  (@w_id_job, 'ICR_SPEC', @w_id_conf, 'JOB_TYPE', 'S')

go
