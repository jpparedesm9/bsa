use cobis
go

create table #tmp_funcionario
(tf_oficial           int         null,
 tf_funcionario       int         null,
 tf_nombre_func       varchar(64) null,
 tf_oficial_superior  int         null,
 tf_funcionario_sup   int         null,
 tf_nombre_superior   varchar(64) null)

insert into #tmp_funcionario(
       tf_oficial         ,  
       tf_funcionario     , 
       tf_nombre_func     ,
       tf_oficial_superior,
       tf_funcionario_sup ,
       tf_nombre_superior)       
select o.oc_oficial       ,
       o.oc_funcionario   ,   
       fo.fu_nombre       ,    
       o.oc_ofi_nsuperior ,
       s.oc_funcionario   ,
       fs.fu_nombre 
from cobis..cl_funcionario fo,
     cobis..cc_oficial o     ,
     cobis..cc_oficial s     ,
     cobis..cl_funcionario fs
where fo.fu_funcionario  =  o.oc_funcionario 
and   o.oc_ofi_nsuperior =  s.oc_oficial
and   s.oc_funcionario   = fs.fu_funcionario

select fu_funcionario,fu_jefe, *
from cobis..cl_funcionario,  cobis..cc_oficial
where fu_funcionario  =  oc_funcionario 

--Se respalda la informacion
if not exists (select 1 from sysobjects where name = 'cl_funcionario_104770') begin
   select * into cl_funcionario_104770
   from cobis..cl_funcionario
end 

update cobis..cl_funcionario 
set     fu_jefe        = tf_funcionario_sup
from  #tmp_funcionario
where   fu_funcionario = tf_funcionario

select fu_funcionario,fu_jefe, *
from cobis..cl_funcionario,  cobis..cc_oficial
where fu_funcionario  =  oc_funcionario 

