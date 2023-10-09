use cob_cartera
go

declare @w_operacion   int,
        @w_sec_ingreso int,
        @w_sec_pago    int,
        @w_sec_corresp int,
        @w_estado_pag  varchar(2),
        @w_error       int,
        @w_banco       cuenta,
        @s_date        datetime,
        @w_oficina     int,
        @w_observacion VARCHAR(255)

select @w_sec_corresp = 35596
select @s_date = fp_fecha from cobis..ba_fecha_proceso
select @w_observacion = ''

select  cd_operacion, cd_banco, 'secuencial_ingreso'=min(cd_sec_ing)
into #pago_reversar
from ca_corresponsal_det, 
           ca_abono,
           ca_abono_det 
where cd_referencia = 'PG0000000019677'
and cd_secuencial     = @w_sec_corresp   
and cd_sec_ing        =  ab_secuencial_ing
and cd_operacion      = ab_operacion
and ab_operacion      = abd_operacion 
and ab_secuencial_ing = abd_secuencial_ing
and cd_sec_ing in (10,15)
group by cd_operacion, cd_banco  

select @w_operacion = 0
while 1 = 1
begin
      select top 1 @w_operacion   = cd_operacion      ,
                   @w_sec_ingreso = secuencial_ingreso,
                   @w_banco       = cd_banco
      from #pago_reversar
      where cd_operacion > @w_operacion
      order by cd_operacion 
      
      if @@ROWCOUNT =0 
         break
         
      select @w_oficina = op_oficina
      from ca_operacion
      where op_banco =  @w_banco  
      
      select @w_sec_pago      = ab_secuencial_pag,
             @w_estado_pag    = ab_estado
      from ca_abono
      where ab_operacion      = @w_operacion
      and   ab_secuencial_ing = @w_sec_ingreso
      
      
      select 'Operacion'      = @w_operacion  , 
             'Secuencial Ing' = @w_sec_ingreso,
             'Secuencial Pag' = @w_sec_pago   ,
             'Secuencial Est' = @w_estado_pag,
             'Banco'          = @w_banco,
             'Oficina'        = @w_oficina,
             'Fecha'          = @s_date
      
      if @w_estado_pag = 'A'
      begin
            exec @w_error = cob_cartera..sp_fecha_valor 
                 @i_banco       = @w_banco,
                 @i_secuencial  = @w_sec_pago  ,
                 @i_operacion   = 'R',
                 @i_observacion = @w_observacion,
                 @i_fecha_mov   = @s_date,
                 @t_trn         = 7049,
                 @s_srv         =  'CTSSRV',
                 @s_user        = 'usrbatch',--@s_user,
                 @s_term        = 'consola',--@s_term,
                 @s_ofi         = @w_oficina,
                 @s_date        = @s_date
            
            if @w_error != 0 
            begin
                select   'ERROR AL EJECUTAR REVERSO DE LA OPERACION : ' + convert(varchar,@w_banco)  + ' error: ' + convert(varchar,@w_error)                      
            end    
            else
            begin
               delete
               from ca_corresponsal_det
               where  cd_secuencial = @w_sec_corresp    
               and    cd_operacion  = @w_operacion
               and    cd_sec_ing    = @w_sec_ingreso
            end  
            
      end  
      else
      begin
           delete
           from ca_corresponsal_det
           where  cd_secuencial = @w_sec_corresp    
           and    cd_operacion  = @w_operacion
           and    cd_sec_ing    = @w_sec_ingreso
      end
          
end


drop table #pago_reversar
