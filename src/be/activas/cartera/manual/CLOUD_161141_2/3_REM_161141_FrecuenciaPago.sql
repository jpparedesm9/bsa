use cob_cartera
go

if exists(select 1 from cob_cartera..ca_tdividendo where td_tdividendo = 'BW')
begin
   print 'Se elimina valor cartocenal'
   delete from cob_cartera..ca_tdividendo where td_tdividendo = 'BW'
   
   print 'Ingreso valor cartocenal'
   INSERT INTO ca_tdividendo (td_tdividendo,td_descripcion,td_estado,td_factor) VALUES('BW','CATORCENAL','V',14)
end
else
begin
   print 'Ingreso valor cartocenal'
   INSERT INTO ca_tdividendo (td_tdividendo,td_descripcion,td_estado,td_factor) VALUES('BW','CATORCENAL','V',14)
end