use cobis
go


set statistics time on;
set statistics io on;

/*set statistics time off;
set statistics io off;
*/

declare @i_codigo_cliente int = 13

select 'Direccion'        = (SELECT  di_calle + ' ' + convert(VARCHAR(10),di_nro)),
             'Estado-Provincia' = e2.eq_valor_arch,
             'Municipio-Ciudad' = isnull(convert(varchar(40),(SELECT cob_conta_super.dbo.fn_formatea_ascii_ext(ci_descripcion,'A'))),''),
             'Colonia-Parroquia' = isnull(convert(varchar(40),(SELECT cob_conta_super.dbo.fn_formatea_ascii_ext(pq_descripcion,'A'))),''),
             'CP' = isnull(convert(varchar(5),di_codpostal),''),                                     
             'CodPais' = 'MX' 
        from cobis..cl_ente e
       inner join cobis..cl_direccion d on (d.di_ente = e.en_ente)	 
       inner join cobis..cl_parroquia p on (pq_parroquia = di_parroquia)
       inner JOIN cobis..cl_ciudad c on (c.ci_ciudad = d.di_ciudad)
       inner join cob_conta_super..sb_equivalencias e1 on (e1.eq_valor_cat = convert(varchar, d.di_provincia)) 
       inner join cob_conta_super..sb_equivalencias e2 on (e2.eq_valor_cat = e1.eq_valor_arch)
       where d.di_tipo in ('RE','AE')
         and en_ente = @i_codigo_cliente
         and e1.eq_catalogo = 'ENT_FED'
         and e2.eq_catalogo = 'ENT_BURO'
         and p.pq_ciudad = c.ci_ciudad