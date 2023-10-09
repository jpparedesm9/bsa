use cob_sincroniza
go

--print 'tabla -----> '

if exists (select 1
           from   sysobjects 
           where  id   = object_id('si_terminal')
           and    type = 'U')
   drop table si_terminal
go

--print 'CREATING... table -----> si_terminal '

create table si_terminal 
(

te_mac varchar(30) not null,
te_mac1 varchar(30) null,
te_mac2 varchar(30) null,
te_reference1 varchar(50) null,
te_reference2 varchar(50) null
)
go

CREATE UNIQUE CLUSTERED INDEX si_terminal_Key
	ON dbo.si_terminal (te_mac)
go
