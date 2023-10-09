update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo = 46
and    gl_id in (4399,4400,4401,4402,4403,4404,4405,4406,4407)
go
