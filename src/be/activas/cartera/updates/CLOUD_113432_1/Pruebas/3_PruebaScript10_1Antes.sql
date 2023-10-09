use cobis
go

set statistics time on;
set statistics io on;

/*set statistics time off;
set statistics io off;
*/

declare @i_codigo_cliente int = 13

select 'Direccion' = (SELECT  di_calle + ' ' + 
								    convert(VARCHAR(10),di_nro)),
            'Estado-Provincia' =     (select top 1 e2.eq_valor_arch
										from cob_conta_super..sb_equivalencias e1, cob_conta_super..sb_equivalencias e2
										where e1.eq_catalogo = 'ENT_FED'
										and e1.eq_valor_cat = convert(varchar, d.di_provincia)
										and e2.eq_catalogo = 'ENT_BURO'
										and e2.eq_valor_cat = e1.eq_valor_arch ),
            'Municipio-Ciudad' = isnull((select top 1 convert(varchar(40),(SELECT cob_conta_super.dbo.fn_formatea_ascii_ext(ci_descripcion,'A'))) from cobis..cl_ciudad c where c.ci_ciudad = d.di_ciudad),''), 
            'Colonia-Parroquia' = isnull((select top 1 convert(varchar(40),(SELECT cob_conta_super.dbo.fn_formatea_ascii_ext(pq_descripcion,'A'))) from cobis..cl_parroquia p where p.pq_parroquia = d.di_parroquia
                                              and p.pq_parroquia = d.di_parroquia),''),
                          'CP' = isnull(convert(varchar(5),di_codpostal),''),                                     
                     'CodPais' = 'MX'                     
          from cobis..cl_direccion d, cobis..cl_ente e
          where d.di_tipo in ('RE','AE')
          and d.di_ente = e.en_ente
          and en_ente = @i_codigo_cliente

go
