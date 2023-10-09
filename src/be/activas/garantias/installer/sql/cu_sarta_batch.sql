use cobis
go

delete ba_sarta_batch
where  sb_sarta = 19201
and sb_batch in (19058,19059,19057,19060)
go

insert into ba_sarta_batch values(19201, 19058, 1, NULL,  'S', 'N', 2000, 1000, 19201, 'S')
insert into ba_sarta_batch values(19201, 19059, 2, NULL,  'S', 'N', 4000, 1000, 19201, 'S')
insert into ba_sarta_batch values(19201, 19057, 3, NULL,  'S', 'N', 6000, 1000, 19201, 'S')
insert into ba_sarta_batch values(19201, 19060, 4, NULL,  'S', 'N', 7830, 1020, 19201, 'S')
go                                                                                    
