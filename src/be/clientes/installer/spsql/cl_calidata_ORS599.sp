/************************************************************************/
/*  Archivo:            cl_calidata_ORS599.sp                           */
/*  Stored procedure:   sp_calidata                                     */
/*  Base de datos:      cobis                                           */
/*  Disenado por:       Edwin Jimenez                                   */
/*  Fecha de escritura: 04-Jul-2013                                     */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*  Este stored procedure genera un archivo plano con la base utilizada */
/*  para la realizacion de las validaciones indicadas por la SFC, con   */
/*  respecto a la calidad de data.                                      */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                               */
/*  04-Jul-2013    E.Jimenez      Emision Inicial                       */
/*  02-May-2016    DFu            Migracion CEN                         */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_calidata')
  drop proc sp_calidata
go

create proc sp_calidata
(
  @i_param1       varchar(10),
  @i_fecha        datetime = null,
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name         varchar(30),
    @w_tipo_ent        varchar(10),
    @w_cod_entidad     varchar(10),
    @w_sp_name_batch   varchar(50),
    @w_path            varchar(255),
    @w_s_app           varchar(255),
    @w_path_plano      varchar(255),
    @w_cmd             varchar(255),
    @w_msg             varchar(100),
    @w_comando         varchar(500),
    @w_errores         varchar(255),
    @w_error           int,
    @w_fecha           datetime,
    @w_fecha_arch      char(8),
    @w_nombre_arch_txt varchar(255),
    @w_nombre_arch_err varchar(255),
    @w_fecha_rep       datetime,
    @w_variables       int,
    @w_total_reg       int,
    @w_inconsistencias int,
    @w_aux             int

  select
    @w_sp_name = 'sp_calidata'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_rep = convert(datetime, @i_param1),
    @w_fecha = convert(varchar, fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  set nocount on

  select
    'HORA INICIO: ' = getdate()

  /*** CREA TABLA UNIVERSO DE TRABAJO ***/
  if exists (select
               1
             from   sysobjects
             where  name = 'cl_dato_sarlaft2')
    drop table cobis..cl_dato_sarlaft2

  if exists (select
               1
             from   cob_conta_super..sysobjects
             where  name = 'sb_cliente_dato_sfc')
    truncate table cob_conta_super..sb_cliente_dato_sfc

  if exists (select
               1
             from   cob_conta_super..sysobjects
             where  name = 'sb_dato_direccion_sfc')
    truncate table cob_conta_super..sb_dato_direccion_sfc

  if exists (select
               1
             from   cob_conta_super..sysobjects
             where  name = 'sb_dato_telefono_sfc')
    truncate table cob_conta_super..sb_dato_telefono_sfc

  if exists (select
               1
             from   cob_conta_super..sysobjects
             where  name = 'sb_dato_socios_sfc')
    truncate table cob_conta_super..sb_dato_socios_sfc

  if exists (select
               1
             from   cob_conta_super..sysobjects
             where  name = 'sb_dato_ente_sfc')
    truncate table cob_conta_super..sb_dato_ente_sfc

  /*** CREA TABLA INFORMACION RESPALDO ***/
  if exists (select
               1
             from   sysobjects
             where  name = 'clientes_todos_ors_586')
    drop table clientes_todos_ors_586

  create table clientes_todos_ors_586
  (
    cliente_t  int null,
    estado     int null,
    aplicativo int null
  )
  create index idx_1
    on clientes_todos_ors_586 (cliente_t)

  /*** CREACION TABLAS TEMPORALES DE TRABAJO***/
  create table #clientes_activos
  (
    cliente_a  int null,
    aplicativo int null
  )
  create table #clientes_pasivos
  (
    cliente_p  int null,
    aplicativo int null
  )
  create table #total_clientes
  (
    clientes int null
  )

  /*** LLENA TABLA DE INFORMACION TOTAL RESPALDO***/
  insert into clientes_todos_ors_586
    select distinct
      do_codigo_cliente,do_estado_cartera,do_aplicativo
    from   cob_conta_super..sb_dato_operacion
    where  do_fecha = @w_fecha_rep
       and do_aplicativo in (7, 203)
       and do_estado_cartera in (1, 2, 4, 9)

  insert into clientes_todos_ors_586
    select distinct
      dp_cliente,dp_estado,dp_aplicativo
    from   cob_conta_super..sb_dato_pasivas
    where  dp_fecha = @w_fecha_rep
       and dp_aplicativo in (14, 4)
       and dp_estado in (1, 2)

/*** SEPARACION DE DATOS ACTIVOS Y PASIVOS ***/
  /*** 'CARGA DE DATOS  PRODUCTOS CCA-PFI-AHO-BONOS' ***/

  insert into #clientes_activos
    select distinct
      do_codigo_cliente,do_aplicativo
    from   cob_conta_super..sb_dato_operacion
    where  do_fecha = @w_fecha_rep
       and do_aplicativo in (7, 203)
       and do_estado_cartera in (1, 2, 4, 9)

  insert into #clientes_pasivos
    select distinct
      dp_cliente,dp_aplicativo
    from   cob_conta_super..sb_dato_pasivas
    where  dp_fecha = @w_fecha_rep
       and dp_aplicativo in (14, 4)
       and dp_estado in (1, 2)

/*** DESCARTA DUPLICIDAD DE CLIENTES PASIVOS - ACTIVOS ***/
  --delete from #clientes_pasivos
  --where  cliente_p in (select cliente_a from #clientes_activos)

  --delete from #clientes_activos
  --where  cliente_a in (select cliente_p from #clientes_pasivos)

  /*** DESCARTAR ENTIDADES VIGILADAS ***/
  create table #ente_vigilado
  (
    cedula varchar(20) null
  )

  insert into #ente_vigilado
  values      ('830032363')
  insert into #ente_vigilado
  values      ('860079923')
  insert into #ente_vigilado
  values      ('8301264781')
  insert into #ente_vigilado
  values      ('8000170433')
  insert into #ente_vigilado
  values      ('8000181658')
  insert into #ente_vigilado
  values      ('8000198072')
  insert into #ente_vigilado
  values      ('8000233909')
  insert into #ente_vigilado
  values      ('8000247028')
  insert into #ente_vigilado
  values      ('8000302544')
  insert into #ente_vigilado
  values      ('8000307631')
  insert into #ente_vigilado
  values      ('8000378008')
  insert into #ente_vigilado
  values      ('8000445754')
  insert into #ente_vigilado
  values      ('8000479997')
  insert into #ente_vigilado
  values      ('8000572186')
  insert into #ente_vigilado
  values      ('8000601426')
  insert into #ente_vigilado
  values      ('8000603368')
  insert into #ente_vigilado
  values      ('8000636065')
  insert into #ente_vigilado
  values      ('8000678400')
  insert into #ente_vigilado
  values      ('8000734932')
  insert into #ente_vigilado
  values      ('8000797429')
  insert into #ente_vigilado
  values      ('8000859777')
  insert into #ente_vigilado
  values      ('8000930713')
  insert into #ente_vigilado
  values      ('8000951316')
  insert into #ente_vigilado
  values      ('8000960369')
  insert into #ente_vigilado
  values      ('8000963291')
  insert into #ente_vigilado
  values      ('8000981040')
  insert into #ente_vigilado
  values      ('8001130688')
  insert into #ente_vigilado
  values      ('8001152802')
  insert into #ente_vigilado
  values      ('8001163987')
  insert into #ente_vigilado
  values      ('8001197532')
  insert into #ente_vigilado
  values      ('8001201843')
  insert into #ente_vigilado
  values      ('8001287358')
  insert into #ente_vigilado
  values      ('8001322424')
  insert into #ente_vigilado
  values      ('8001355241')
  insert into #ente_vigilado
  values      ('8001367701')
  insert into #ente_vigilado
  values      ('8001380844')
  insert into #ente_vigilado
  values      ('8001381881')
  insert into #ente_vigilado
  values      ('8001392931')
  insert into #ente_vigilado
  values      ('8001400944')
  insert into #ente_vigilado
  values      ('8001408878')
  insert into #ente_vigilado
  values      ('8001410211')
  insert into #ente_vigilado
  values      ('8001412350')
  insert into #ente_vigilado
  values      ('8001423837')
  insert into #ente_vigilado
  values      ('8001426381')
  insert into #ente_vigilado
  values      ('8001431573')
  insert into #ente_vigilado
  values      ('8001434071')
  insert into #ente_vigilado
  values      ('8001443313')
  insert into #ente_vigilado
  values      ('8001444676')
  insert into #ente_vigilado
  values      ('8001468148')
  insert into #ente_vigilado
  values      ('8001470383')
  insert into #ente_vigilado
  values      ('8001470423')
  insert into #ente_vigilado
  values      ('8001475021')
  insert into #ente_vigilado
  values      ('8001485142')
  insert into #ente_vigilado
  values      ('8001493459')
  insert into #ente_vigilado
  values      ('8001494529')
  insert into #ente_vigilado
  values      ('8001494962')
  insert into #ente_vigilado
  values      ('8001498166')
  insert into #ente_vigilado
  values      ('8001499236')
  insert into #ente_vigilado
  values      ('8001502800')
  insert into #ente_vigilado
  values      ('8001539905')
  insert into #ente_vigilado
  values      ('8001554136')
  insert into #ente_vigilado
  values      ('8001599980')
  insert into #ente_vigilado
  values      ('8001687635')
  insert into #ente_vigilado
  values      ('8001694968')
  insert into #ente_vigilado
  values      ('8001713721')
  insert into #ente_vigilado
  values      ('8001781488')
  insert into #ente_vigilado
  values      ('8001820912')
  insert into #ente_vigilado
  values      ('8001822815')
  insert into #ente_vigilado
  values      ('8001833019')
  insert into #ente_vigilado
  values      ('8001863621')
  insert into #ente_vigilado
  values      ('8001881781')
  insert into #ente_vigilado
  values      ('8001889977')
  insert into #ente_vigilado
  values      ('8001896042')
  insert into #ente_vigilado
  values      ('8001980731')
  insert into #ente_vigilado
  values      ('8001991320')
  insert into #ente_vigilado
  values      ('8002031865')
  insert into #ente_vigilado
  values      ('8002057824')
  insert into #ente_vigilado
  values      ('8002064421')
  insert into #ente_vigilado
  values      ('8002140019')
  insert into #ente_vigilado
  values      ('8002158033')
  insert into #ente_vigilado
  values      ('8002162780')
  insert into #ente_vigilado
  values      ('8002165674')
  insert into #ente_vigilado
  values      ('8002220915')
  insert into #ente_vigilado
  values      ('8002224814')
  insert into #ente_vigilado
  values      ('8002250410')
  insert into #ente_vigilado
  values      ('8002253859')
  insert into #ente_vigilado
  values      ('8002260984')
  insert into #ente_vigilado
  values      ('8002261753')
  insert into #ente_vigilado
  values      ('8002354265')
  insert into #ente_vigilado
  values      ('8002408820')
  insert into #ente_vigilado
  values      ('8002453514')
  insert into #ente_vigilado
  values      ('8002453514')
  insert into #ente_vigilado
  values      ('8002471549')
  insert into #ente_vigilado
  values      ('8002474909')
  insert into #ente_vigilado
  values      ('8002561619')
  insert into #ente_vigilado
  values      ('8020005587')
  insert into #ente_vigilado
  values      ('8020038370')
  insert into #ente_vigilado
  values      ('8020174590')
  insert into #ente_vigilado
  values      ('8050008679')
  insert into #ente_vigilado
  values      ('8050103330')
  insert into #ente_vigilado
  values      ('8050235981')
  insert into #ente_vigilado
  values      ('8110077294')
  insert into #ente_vigilado
  values      ('8110152272')
  insert into #ente_vigilado
  values      ('8110154057')
  insert into #ente_vigilado
  values      ('8110178793')
  insert into #ente_vigilado
  values      ('8110191907')
  insert into #ente_vigilado
  values      ('8110226883')
  insert into #ente_vigilado
  values      ('8110436608')
  insert into #ente_vigilado
  values      ('8300086861')
  insert into #ente_vigilado
  values      ('8300103854')
  insert into #ente_vigilado
  values      ('8300119407')
  insert into #ente_vigilado
  values      ('8300133990')
  insert into #ente_vigilado
  values      ('8300148925')
  insert into #ente_vigilado
  values      ('8300159182')
  insert into #ente_vigilado
  values      ('8300180041')
  insert into #ente_vigilado
  values      ('8300183273')
  insert into #ente_vigilado
  values      ('8300220321')
  insert into #ente_vigilado
  values      ('8300264931')
  insert into #ente_vigilado
  values      ('8300275325')
  insert into #ente_vigilado
  values      ('8300306291')
  insert into #ente_vigilado
  values      ('8300352173')
  insert into #ente_vigilado
  values      ('8300361495')
  insert into #ente_vigilado
  values      ('8300366457')
  insert into #ente_vigilado
  values      ('8300366661')
  insert into #ente_vigilado
  values      ('8300396744')
  insert into #ente_vigilado
  values      ('8300397996')
  insert into #ente_vigilado
  values      ('8300429646')
  insert into #ente_vigilado
  values      ('8300434926')
  insert into #ente_vigilado
  values      ('8300438484')
  insert into #ente_vigilado
  values      ('8300450954')
  insert into #ente_vigilado
  values      ('8300453515')
  insert into #ente_vigilado
  values      ('8300485135')
  insert into #ente_vigilado
  values      ('8300521826')
  insert into #ente_vigilado
  values      ('8300533192')
  insert into #ente_vigilado
  values      ('8300545390')
  insert into #ente_vigilado
  values      ('8300549046')
  insert into #ente_vigilado
  values      ('8300705271')
  insert into #ente_vigilado
  values      ('8300785126')
  insert into #ente_vigilado
  values      ('8300832723')
  insert into #ente_vigilado
  values      ('8300854261')
  insert into #ente_vigilado
  values      ('8300895306')
  insert into #ente_vigilado
  values      ('8300915941')
  insert into #ente_vigilado
  values      ('8300942831')
  insert into #ente_vigilado
  values      ('8300972240')
  insert into #ente_vigilado
  values      ('8300983694')
  insert into #ente_vigilado
  values      ('8301030652')
  insert into #ente_vigilado
  values      ('8301038285')
  insert into #ente_vigilado
  values      ('8301041963')
  insert into #ente_vigilado
  values      ('8301150543')
  insert into #ente_vigilado
  values      ('8301159285')
  insert into #ente_vigilado
  values      ('8301181205')
  insert into #ente_vigilado
  values      ('8301260637')
  insert into #ente_vigilado
  values      ('8301311531')
  insert into #ente_vigilado
  values      ('8301369911')
  insert into #ente_vigilado
  values      ('8305047002')
  insert into #ente_vigilado
  values      ('8600001854')
  insert into #ente_vigilado
  values      ('8600021538')
  insert into #ente_vigilado
  values      ('8600021807')
  insert into #ente_vigilado
  values      ('8600021821')
  insert into #ente_vigilado
  values      ('8600021839')
  insert into #ente_vigilado
  values      ('8600021846')
  insert into #ente_vigilado
  values      ('8600022869')
  insert into #ente_vigilado
  values      ('8600023985')
  insert into #ente_vigilado
  values      ('8600024002')
  insert into #ente_vigilado
  values      ('8600025032')
  insert into #ente_vigilado
  values      ('8600025041')
  insert into #ente_vigilado
  values      ('8600025057')
  insert into #ente_vigilado
  values      ('8600025279')
  insert into #ente_vigilado
  values      ('8600025340')
  insert into #ente_vigilado
  values      ('8600029454')
  insert into #ente_vigilado
  values      ('8600029644')
  insert into #ente_vigilado
  values      ('8600030201')
  insert into #ente_vigilado
  values      ('8600048756')
  insert into #ente_vigilado
  values      ('8600052167')
  insert into #ente_vigilado
  values      ('8600063596')
  insert into #ente_vigilado
  values      ('8600067979')
  insert into #ente_vigilado
  values      ('8600073354')
  insert into #ente_vigilado
  values      ('8600073537')
  insert into #ente_vigilado
  values      ('8600073798')
  insert into #ente_vigilado
  values      ('8600076603')
  insert into #ente_vigilado
  values      ('8600077389')
  insert into #ente_vigilado
  values      ('8600081495')
  insert into #ente_vigilado
  values      ('8600086457')
  insert into #ente_vigilado
  values      ('8600091744')
  insert into #ente_vigilado
  values      ('8600091959')
  insert into #ente_vigilado
  values      ('8600095786')
  insert into #ente_vigilado
  values      ('8600099345')
  insert into #ente_vigilado
  values      ('8600101707')
  insert into #ente_vigilado
  values      ('8600109734')
  insert into #ente_vigilado
  values      ('8600111536')
  insert into #ente_vigilado
  values      ('8600147822')
  insert into #ente_vigilado
  values      ('8600203824')
  insert into #ente_vigilado
  values      ('8600207597')
  insert into #ente_vigilado
  values      ('8600219677')
  insert into #ente_vigilado
  values      ('8600221375')
  insert into #ente_vigilado
  values      ('8600230531')
  insert into #ente_vigilado
  values      ('8600244141')
  insert into #ente_vigilado
  values      ('8600248586')
  insert into #ente_vigilado
  values      ('8600259034')
  insert into #ente_vigilado
  values      ('8600259715')
  insert into #ente_vigilado
  values      ('8600261825')
  insert into #ente_vigilado
  values      ('8600265186')
  insert into #ente_vigilado
  values      ('8600274041')
  insert into #ente_vigilado
  values      ('8600278289')
  insert into #ente_vigilado
  values      ('8600284155')
  insert into #ente_vigilado
  values      ('8600293968')
  insert into #ente_vigilado
  values      ('8600299777')
  insert into #ente_vigilado
  values      ('8600300893')
  insert into #ente_vigilado
  values      ('8600318087')
  insert into #ente_vigilado
  values      ('8600319798')
  insert into #ente_vigilado
  values      ('8600323303')
  insert into #ente_vigilado
  values      ('8600329097')
  insert into #ente_vigilado
  values      ('8600343137')
  insert into #ente_vigilado
  values      ('8600345205')
  insert into #ente_vigilado
  values      ('8600345941')
  insert into #ente_vigilado
  values      ('8600350975')
  insert into #ente_vigilado
  values      ('8600358275')
  insert into #ente_vigilado
  values      ('8600370136')
  insert into #ente_vigilado
  values      ('8600377079')
  insert into #ente_vigilado
  values      ('8600382991')
  insert into #ente_vigilado
  values      ('8600399880')
  insert into #ente_vigilado
  values      ('8600413713')
  insert into #ente_vigilado
  values      ('8600431866')
  insert into #ente_vigilado
  values      ('8600444897')
  insert into #ente_vigilado
  values      ('8600486085')
  insert into #ente_vigilado
  values      ('8600487836')
  insert into #ente_vigilado
  values      ('8600503901')
  insert into #ente_vigilado
  values      ('8600507501')
  insert into #ente_vigilado
  values      ('8600509309')
  insert into #ente_vigilado
  values      ('8600511354')
  insert into #ente_vigilado
  values      ('8600511759')
  insert into #ente_vigilado
  values      ('8600518946')
  insert into #ente_vigilado
  values      ('8600523309')
  insert into #ente_vigilado
  values      ('8600527817')
  insert into #ente_vigilado
  values      ('8600567847')
  insert into #ente_vigilado
  values      ('8600589566')
  insert into #ente_vigilado
  values      ('8600592943')
  insert into #ente_vigilado
  values      ('8600611998')
  insert into #ente_vigilado
  values      ('8600659139')
  insert into #ente_vigilado
  values      ('8600662571')
  insert into #ente_vigilado
  values      ('8600672037')
  insert into #ente_vigilado
  values      ('8600681825')
  insert into #ente_vigilado
  values      ('8600685907')
  insert into #ente_vigilado
  values      ('8600691955')
  insert into #ente_vigilado
  values      ('8600692652')
  insert into #ente_vigilado
  values      ('8600703749')
  insert into #ente_vigilado
  values      ('8600712509')
  insert into #ente_vigilado
  values      ('8600715621')
  insert into #ente_vigilado
  values      ('8600725894')
  insert into #ente_vigilado
  values      ('8600730794')
  insert into #ente_vigilado
  values      ('8600791743')
  insert into #ente_vigilado
  values      ('8600799810')
  insert into #ente_vigilado
  values      ('8600801358')
  insert into #ente_vigilado
  values      ('8603529186')
  insert into #ente_vigilado
  values      ('8603535876')
  insert into #ente_vigilado
  values      ('8604022722')
  insert into #ente_vigilado
  values      ('8605005315')
  insert into #ente_vigilado
  values      ('8605014486')
  insert into #ente_vigilado
  values      ('8605036173')
  insert into #ente_vigilado
  values      ('8605037481')
  insert into #ente_vigilado
  values      ('8605058004')
  insert into #ente_vigilado
  values      ('8605060311')
  insert into #ente_vigilado
  values      ('8605090229')
  insert into #ente_vigilado
  values      ('8605094443')
  insert into #ente_vigilado
  values      ('8605098589')
  insert into #ente_vigilado
  values      ('8605102037')
  insert into #ente_vigilado
  values      ('8605108960')
  insert into #ente_vigilado
  values      ('8605192883')
  insert into #ente_vigilado
  values      ('8605226593')
  insert into #ente_vigilado
  values      ('8605246546')
  insert into #ente_vigilado
  values      ('8605251485')
  insert into #ente_vigilado
  values      ('8605266601')
  insert into #ente_vigilado
  values      ('8605286773')
  insert into #ente_vigilado
  values      ('8605307517')
  insert into #ente_vigilado
  values      ('8605313153')
  insert into #ente_vigilado
  values      ('8605351155')
  insert into #ente_vigilado
  values      ('8901053149')
  insert into #ente_vigilado
  values      ('8902007567')
  insert into #ente_vigilado
  values      ('8902030889')
  insert into #ente_vigilado
  values      ('8902069071')
  insert into #ente_vigilado
  values      ('8903000401')
  insert into #ente_vigilado
  values      ('8903002794')
  insert into #ente_vigilado
  values      ('8903003832')
  insert into #ente_vigilado
  values      ('8903004658')
  insert into #ente_vigilado
  values      ('8903006536')
  insert into #ente_vigilado
  values      ('8903015840')
  insert into #ente_vigilado
  values      ('8903016476')
  insert into #ente_vigilado
  values      ('8903112706')
  insert into #ente_vigilado
  values      ('8903185322')
  insert into #ente_vigilado
  values      ('8903229051')
  insert into #ente_vigilado
  values      ('8909011763')
  insert into #ente_vigilado
  values      ('8909011770')
  insert into #ente_vigilado
  values      ('8909015014')
  insert into #ente_vigilado
  values      ('8909016044')
  insert into #ente_vigilado
  values      ('8909032792')
  insert into #ente_vigilado
  values      ('8909034079')
  insert into #ente_vigilado
  values      ('8909037905')
  insert into #ente_vigilado
  values      ('8909039370')
  insert into #ente_vigilado
  values      ('8909039388')
  insert into #ente_vigilado
  values      ('8909041165')
  insert into #ente_vigilado
  values      ('8909053750')
  insert into #ente_vigilado
  values      ('8909060252')
  insert into #ente_vigilado
  values      ('8909071570')
  insert into #ente_vigilado
  values      ('8909074890')
  insert into #ente_vigilado
  values      ('8909085704')
  insert into #ente_vigilado
  values      ('8909110284')
  insert into #ente_vigilado
  values      ('8909262831')
  insert into #ente_vigilado
  values      ('8909270349')
  insert into #ente_vigilado
  values      ('8909316099')
  insert into #ente_vigilado
  values      ('8909813951')
  insert into #ente_vigilado
  values      ('8909857519')
  insert into #ente_vigilado
  values      ('8914107712')
  insert into #ente_vigilado
  values      ('8915003160')
  insert into #ente_vigilado
  values      ('8915007550')
  insert into #ente_vigilado
  values      ('8917000379')
  insert into #ente_vigilado
  values      ('8999990260')
  insert into #ente_vigilado
  values      ('8999990357')
  insert into #ente_vigilado
  values      ('8999990491')
  insert into #ente_vigilado
  values      ('8999992844')
  insert into #ente_vigilado
  values      ('8999993161')
  insert into #ente_vigilado
  values      ('8999997347')
  insert into #ente_vigilado
  values      ('9000027904')
  insert into #ente_vigilado
  values      ('9000479818')
  insert into #ente_vigilado
  values      ('9000501970')
  insert into #ente_vigilado
  values      ('9000526354')
  insert into #ente_vigilado
  values      ('9000555715')
  insert into #ente_vigilado
  values      ('9000905293')
  insert into #ente_vigilado
  values      ('9000922306')
  insert into #ente_vigilado
  values      ('9000985623')
  insert into #ente_vigilado
  values      ('9001143142')
  insert into #ente_vigilado
  values      ('9001143468')
  insert into #ente_vigilado
  values      ('9001155523')
  insert into #ente_vigilado
  values      ('9001161897')
  insert into #ente_vigilado
  values      ('9001180802')
  insert into #ente_vigilado
  values      ('9001186779')
  insert into #ente_vigilado
  values      ('9001228992')
  insert into #ente_vigilado
  values      ('9001256563')
  insert into #ente_vigilado
  values      ('9001298568')
  insert into #ente_vigilado
  values      ('9001632530')
  insert into #ente_vigilado
  values      ('9001658689')
  insert into #ente_vigilado
  values      ('9001682311')
  insert into #ente_vigilado
  values      ('9001788227')
  insert into #ente_vigilado
  values      ('9001823894')
  insert into #ente_vigilado
  values      ('9001965039')
  insert into #ente_vigilado
  values      ('9002004353')
  insert into #ente_vigilado
  values      ('9002009609')
  insert into #ente_vigilado
  values      ('9002024280')
  insert into #ente_vigilado
  values      ('9002150711')
  insert into #ente_vigilado
  values      ('9002435048')
  insert into #ente_vigilado
  values      ('9002664151')
  insert into #ente_vigilado
  values      ('9002958962')
  insert into #ente_vigilado
  values      ('9003050836')
  insert into #ente_vigilado
  values      ('9003077112')
  insert into #ente_vigilado
  values      ('9003220884')
  insert into #ente_vigilado
  values      ('9003223398')
  insert into #ente_vigilado
  values      ('9003256626')
  insert into #ente_vigilado
  values      ('9003360047')
  insert into #ente_vigilado
  values      ('9003506678')
  insert into #ente_vigilado
  values      ('9003639686')
  insert into #ente_vigilado
  values      ('9003671641')
  insert into #ente_vigilado
  values      ('9003695247')
  insert into #ente_vigilado
  values      ('9003695293')
  insert into #ente_vigilado
  values      ('9003771707')
  insert into #ente_vigilado
  values      ('9003782122')
  insert into #ente_vigilado
  values      ('9003800717')
  insert into #ente_vigilado
  values      ('9003817869')
  insert into #ente_vigilado
  values      ('9003830695')
  insert into #ente_vigilado
  values      ('9003861561')
  insert into #ente_vigilado
  values      ('9003890012')
  insert into #ente_vigilado
  values      ('9004061505')
  insert into #ente_vigilado
  values      ('9004064721')
  insert into #ente_vigilado
  values      ('9004085370')
  insert into #ente_vigilado
  values      ('9004093630')
  insert into #ente_vigilado
  values      ('9004213719')
  insert into #ente_vigilado
  values      ('9004335075')
  insert into #ente_vigilado
  values      ('9004458713')
  insert into #ente_vigilado
  values      ('9004881513')
  insert into #ente_vigilado
  values      ('9005157597')
  insert into #ente_vigilado
  values      ('9005199459')
  insert into #ente_vigilado
  values      ('9005204847')
  insert into #ente_vigilado
  values      ('9005324405')
  insert into #ente_vigilado
  values      ('9005685795')
  insert into #ente_vigilado
  values      ('9005771404')
  insert into #ente_vigilado
  values      ('9005947476')

  delete from #clientes_pasivos
  where  cliente_p in
         (select
            en_ente
          from   cobis..cl_ente
          where  en_ced_ruc in
                 (select
                    cedula
                  from   #ente_vigilado))

  delete from #clientes_activos
  where  cliente_a in
         (select
            en_ente
          from   cobis..cl_ente
          where  en_ced_ruc in
                 (select
                    cedula
                  from   #ente_vigilado))

  /*** UNIFICACION PASIVOS ACTIVOS ***/
  insert into #total_clientes
    select distinct
      cliente_p
    from   #clientes_pasivos
    union
    select
      cliente_a
    from   #clientes_activos

/*  '------------------------------------------'
    '-   DETALLE PRODUCTOS DE LOS CLIENTES    -'
    '------------------------------------------' */
  /*** EXTRAE DEUDOR PPAL DE ACTIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_a,'DEUDOR PPAL - ACTIVAS',@w_fecha,aplicativo
    from   cob_conta_super..sb_dato_deudores,
           #clientes_activos
    where  de_fecha      = @w_fecha_rep
       and de_aplicativo = 7
       and de_cliente    = cliente_a --cliente del repositorio UNICO 
       and de_rol        = 'D'

  /*** EXTRAE TITULARES DE PASIVAS ***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_p,'TITULAR - PASIVAS',@w_fecha,aplicativo
    from   cobis..cl_cliente with (nolock),
           cobis..cl_det_producto with (nolock),
           #clientes_pasivos
    where  cl_det_producto = dp_det_producto
       and cl_rol          = 'T'
       and dp_estado_ser   = 'V'
       and cl_cliente      = cliente_p --cliente del repositorio UNICO
       and dp_cliente_ec   = cliente_p
       and dp_producto in (4, 14)
       and cliente_p not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE CODEUDOR DE ACTIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_a,'CODEUDOR - ACTIVAS',@w_fecha,aplicativo
    from   cob_conta_super..sb_dato_deudores,
           #clientes_activos
    where  de_fecha      = @w_fecha_rep
       and de_aplicativo = 7
       and de_cliente    = cliente_a --cliente del repositorio UNICO 
       and de_rol        = 'C'
       and cliente_a not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE COOTITULAR DE PASIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_p,'COOTITULAR - PASIVAS',@w_fecha,aplicativo
    from   cobis..cl_cliente with (nolock),
           cobis..cl_det_producto with (nolock),
           #clientes_pasivos
    where  cl_det_producto = dp_det_producto
       and cl_rol          = 'C'
       and dp_estado_ser   = 'V'
       and cl_cliente      = cliente_p --cliente del repositorio UNICO
       and dp_cliente_ec   = cliente_p
       and dp_producto in (4, 14)
       and cliente_p not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE AVALISTA DE ACTIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_a,'AVALISTA - ACTIVAS',@w_fecha,aplicativo
    from   cob_conta_super..sb_dato_deudores,
           #clientes_activos
    where  de_fecha      = @w_fecha_rep
       and de_aplicativo = 7
       and de_cliente    = cliente_a --cliente del repositorio UNICO 
       and de_rol        = 'A'
       and cliente_a not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE FIRMANTES DE PASIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_p,'FIRMA AUTORIZADA - PASIVAS',@w_fecha,aplicativo
    from   cobis..cl_cliente with (nolock),
           cobis..cl_det_producto with (nolock),
           #clientes_pasivos
    where  cl_det_producto = dp_det_producto
       and cl_rol          = 'F'
       and dp_estado_ser   = 'V'
       and cl_cliente      = cliente_p --cliente del repositorio UNICO
       and dp_cliente_ec   = cliente_p
       and dp_producto in (4, 14)
       and cliente_p not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE DEUDOR SOLIDARIO ACTIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_a,'DEUDOR SOLIDARIO - ACTIVAS',@w_fecha,aplicativo
    from   cob_conta_super..sb_dato_deudores,
           #clientes_activos
    where  de_fecha      = @w_fecha_rep
       and de_aplicativo = 7
       and de_cliente    = cliente_a --cliente del repositorio UNICO 
       and de_rol        = 'S'
       and cliente_a not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE TUTOR DE PASIVAS***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cliente_p,'TUTOR - PASIVAS',@w_fecha,aplicativo
    from   cobis..cl_cliente with (nolock),
           cobis..cl_det_producto with (nolock),
           #clientes_pasivos
    where  cl_det_producto = dp_det_producto
       and cl_rol          = 'U'
       and dp_estado_ser   = 'V'
       and cl_cliente      = cliente_p --cliente del repositorio UNICO
       and dp_cliente_ec   = cliente_p
       and dp_producto in (4, 14)
       and cliente_p not in (select
                               cliente_u
                             from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAE LOS ROLES DE ENTES ACTIVAS ***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      de_cliente,case de_rol
        when 'D' then 'DEUDOR PPAL - ACTIVAS'
        when 'C' then 'CODEUDOR - ACTIVAS'
        when 'A' then 'AVALISTA - ACTIVAS'
        when 'S' then 'DEUDOR SOLIDARIO - ACTIVAS'
      end,@w_fecha,aplicativo
    from   cob_conta_super..sb_dato_deudores,
           #clientes_activos
    where  de_fecha      <= @w_fecha_rep
       and de_aplicativo = 7
       and de_cliente    = cliente_a --cliente del repositorio UNICO 
       and de_cliente in
           (select
              clientes
            from   #total_clientes)
       and de_cliente not in (select
                                cliente_u
                              from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAER LOS ROLES DE ENTES PASIVAS CON PRODUCTOS ***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select distinct
      cl_cliente,case cl_rol
        when 'T' then 'TITULAR - PASIVAS'
        when 'C' then 'COOTITULAR - PASIVAS'
        when 'F' then 'FIRMA AUTORIZADA - PASIVAS'
        when 'U' then 'TUTOR - PASIVAS'
      end,@w_fecha,dp_producto
    from   cobis..cl_cliente with (nolock),
           cobis..cl_det_producto with (nolock)
    where  cl_det_producto = dp_det_producto
       and dp_producto     = 14
       and dp_estado_ser   = 'V'
       and cl_cliente in
           (select
              clientes
            from   #total_clientes)
       and cl_cliente not in (select
                                cliente_u
                              from   cob_conta_super..sb_cliente_dato_sfc)

  /*** EXTRAER LOS ENTES FALTANTES DE TITULARIDAD (BONOS) ***/
  insert into cob_conta_super..sb_cliente_dato_sfc
    select
      clientes,'OTROS',@w_fecha,null
    from   #total_clientes
    where  clientes not in (select
                              cliente_u
                            from   cob_conta_super..sb_cliente_dato_sfc)

  /*** reporte cobis..sp_calidata_base **/
  select
    @w_variables = 0,
    @w_inconsistencias = 0

  select
    *
  into   #clientesPersonas
  from   cobis..cl_ente,
         cob_conta_super..sb_cliente_dato_sfc
  where  en_ente    = cliente_u
     and en_subtipo = 'P'

  create table #inf_tabla1
  (
    Descripcion varchar(180)
  )

  insert into #inf_tabla1
    select
      'Cantidad PERSONA  NATURAL => ' + convert(varchar(12), count(distinct
      en_ente)
      )
    from   #clientesPersonas

  insert into #inf_tabla1
    select
      '---------------  CAMPO (1) FORMATO 3  Nombres y apellidos'

  insert into #inf_tabla1
    select
      'CAmpo:cl_ente.en_nomlar '

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(1)
  from   #clientesPersonas
  where  en_nomlar like ('%º%')
      or en_nomlar like ('%!%')
      or en_nomlar like ('%"%')
      or en_nomlar like ('%*%')
      or en_nomlar like ('%&%')
      or en_nomlar like ('%|%')
      or en_nomlar like ('%$%')
      or en_nomlar like ('%(%')
      or en_nomlar like ('%;%')
      or en_nomlar like ('%)%')
      or en_nomlar like ('%:%')
      or en_nomlar like ('%[%')
      or en_nomlar like ('%]%')
      or en_nomlar like ('%{%')
      or en_nomlar like ('%}%')
      or en_nomlar like ('%~%')
      or en_nomlar like ('%+%')
      or en_nomlar like ('%¼%')
      or en_nomlar like ('%@%')
      or en_nomlar like ('%#%')
      or en_nomlar like ('%0%')
      or en_nomlar like ('%1%')
      or en_nomlar like ('%2%')
      or en_nomlar like ('%3%')
      or en_nomlar like ('%4%')
      or en_nomlar like ('%5%')
      or en_nomlar like ('%6%')
      or en_nomlar like ('%7%')
      or en_nomlar like ('%8%')
      or en_nomlar like ('%9%')
      or len(en_nomlar) = 1

  insert into #inf_tabla1
    select
      'en_nomlar con Inconcistencias => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'en_nomlar Vacio => ' + convert(varchar(12), count(1))
    from   #clientesPersonas
    where  ltrim(rtrim(en_nomlar)) = ''
        or en_nomlar is null

  insert into #inf_tabla1
    select
      'en_nomlar en 0 => ' + convert(varchar(12), count(1))
    from   #clientesPersonas
    where  en_nomlar = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (2) FORMATO 3 Identificacion Cedula '

  insert into #inf_tabla1
    select
      'Campo: cl_ente.en_ced_ruc '

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  en_ced_ruc like ('%º%')
      or en_ced_ruc like ('%!%')
      or en_ced_ruc like ('%"%')
      or en_ced_ruc like ('%*%')
      or en_ced_ruc like ('%&%')
      or en_ced_ruc like ('%|%')
      or en_ced_ruc like ('%$%')
      or en_ced_ruc like ('%(%')
      or en_ced_ruc like ('%;%')
      or en_ced_ruc like ('%)%')
      or en_ced_ruc like ('%:%')
      or en_ced_ruc like ('%[%')
      or en_ced_ruc like ('%]%')
      or en_ced_ruc like ('%{%')
      or en_ced_ruc like ('%}%')
      or en_ced_ruc like ('%~%')
      or en_ced_ruc like ('%+%')
      or en_ced_ruc like ('%¼%')
      or en_ced_ruc like ('%@%')
      or en_ced_ruc like ('%#%')
      or len(en_ced_ruc)                 = 1
      or len(replace(en_ced_ruc,
                     '0',
                     '')) = 0

  insert into #inf_tabla1
    select
      'Numero Identificacion Con inconsistencias => ' + convert(varchar(12),
      @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Numero Identificacion en Vacio => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesPersonas
    where  en_ced_ruc is null
        or en_ced_ruc = ''

  insert into #inf_tabla1
    select
      'Numero Identificacion en 0 => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesPersonas
    where  en_ced_ruc = '0'

  insert into #inf_tabla1
    select
  '----- Validacion de cedulas duplicadas . Este script crea Tablas temporales'

  insert into #inf_tabla1
    select
      'Numero Identificacion Duplicadas => '
      + convert(varchar(12), count(distinct en_ced_ruc))
    from   #clientesPersonas
    group  by en_ced_ruc
    having count(distinct en_ced_ruc) > 1

  select
    'cedula' = en_ced_ruc,
    'tipo_ced' = en_tipo_ced,
    'cant' = count(distinct en_ente)
  into   #cedrep -- Codigos de  numeros de documentos  repetidas
  from   #clientesPersonas
  group  by en_ced_ruc,
            en_tipo_ced
  having count(distinct en_ced_ruc) > 1

  select
    ente = en_ente,
    cedula = en_ced_ruc
  into   #enterep
  -- codigos de los entes que estan con numeros de documentos repetidos
  from   cobis..cl_ente,
         #cedrep
  where  en_ced_ruc = cedula

  insert into #inf_tabla1
    select
      '---------------  CAMPO (3) FORMATO 3 Lugar de Nacimiento'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.p_ciudad_nac'

  insert into #inf_tabla1
    select
      '----- Validacion de ciudad de nacimiento sea null'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  p_ciudad_nac like ('%º%')
      or p_ciudad_nac like ('%!%')
      or p_ciudad_nac like ('%"%')
      or p_ciudad_nac like ('%*%')
      or p_ciudad_nac like ('%&%')
      or p_ciudad_nac like ('%|%')
      or p_ciudad_nac like ('%$%')
      or p_ciudad_nac like ('%(%')
      or p_ciudad_nac like ('%;%')
      or p_ciudad_nac like ('%)%')
      or p_ciudad_nac like ('%:%')
      or p_ciudad_nac like ('%[%')
      or p_ciudad_nac like ('%]%')
      or p_ciudad_nac like ('%{%')
      or p_ciudad_nac like ('%}%')
      or p_ciudad_nac like ('%~%')
      or p_ciudad_nac like ('%+%')
      or p_ciudad_nac like ('%¼%')
      or p_ciudad_nac like ('%@%')
      or p_ciudad_nac like ('%#%') --or len(p_ciudad_nac ) = 1

  insert into #inf_tabla1
    select
      'Lugar de Nacimiento Inconsistencias => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Lugar de Nacimiento Vacio => ' + convert(varchar(12), count(distinct
      en_ente)
      )
    from   #clientesPersonas
    where  p_ciudad_nac is null
        or p_ciudad_nac = ''
           and p_ciudad_nac <> 0

  insert into #inf_tabla1
    select
      'Lugar de Nacimiento en 0 => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesPersonas
    where  p_ciudad_nac = 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (4) FORMATO 3 FEcha de Nacimiento'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.p_fecha_nac'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  p_fecha_nac like ('%º%')
      or p_fecha_nac like ('%!%')
      or p_fecha_nac like ('%"%')
      or p_fecha_nac like ('%*%')
      or p_fecha_nac like ('%&%')
      or p_fecha_nac like ('%|%')
      or p_fecha_nac like ('%$%')
      or p_fecha_nac like ('%(%')
      or p_fecha_nac like ('%;%')
      or p_fecha_nac like ('%)%')
      or p_fecha_nac like ('%<%')
      or p_fecha_nac like ('%[%')
      or p_fecha_nac like ('%]%')
      or p_fecha_nac like ('%{%')
      or p_fecha_nac like ('%}%')
      or p_fecha_nac like ('%~%')
      or p_fecha_nac like ('%+%')
      or p_fecha_nac like ('%¼%')
      or p_fecha_nac like ('%@%')
      or p_fecha_nac like ('%#%')
      or len(p_fecha_nac) = 1
      or p_fecha_nac      >= getdate()
      or p_fecha_nac      >= p_fecha_emision

  insert into #inf_tabla1
    select
      'Fecha Nacimiento Inconsistencias => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Fecha Nacimiento Vacio => ' + convert(varchar(12), count(distinct en_ente
      )
      )
    from   #clientesPersonas
    where  p_fecha_nac is null
        or p_fecha_nac = ''

  insert into #inf_tabla1
    select
      'Fecha Nacimiento en 0 => ' + convert(varchar(12), count(distinct en_ente)
      )
    from   #clientesPersonas
    where  p_fecha_nac = 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (5) FORMATO 3  Direccion de Residencia'

  insert into #inf_tabla1
    select
      'Campo: cl_direccion.di_descripcion'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
         left join cobis..cl_direccion
                on di_ente = en_ente
                   and di_direccion = en_direccion
                   and di_tipo = '002' ----Direccion de Residencia
  where  (di_descripcion like ('%º%')
       or di_descripcion like ('%!%')
       or di_descripcion like ('%"%')
       or di_descripcion like ('%*%')
       or di_descripcion like ('%&%')
       or di_descripcion like ('%|%')
       or di_descripcion like ('%$%')
       or di_descripcion like ('%(%')
       or di_descripcion like ('%;%')
       or di_descripcion like ('%)%')
       or di_descripcion like ('%:%')
       or di_descripcion like ('%[%')
       or di_descripcion like ('%]%')
       or di_descripcion like ('%{%')
       or di_descripcion like ('%}%')
       or di_descripcion like ('%=%')
       or di_descripcion like ('%+%')
       or di_descripcion like ('%¼%')
       or di_descripcion like ('%@%')
       or di_descripcion like ('%/%')
       or len(di_descripcion) = 1)

  insert into #inf_tabla1
    select
      'Direccion de Residencia Vacio => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesPersonas
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '002'
    where  (ltrim(rtrim(di_descripcion)) = ''
         or di_descripcion is null)

  insert into #inf_tabla1
    select
      'Direccion de Residencia en 0 => ' + convert(varchar(12), count(distinct
      en_ente
      ))
    from   #clientesPersonas
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '002' ----Direccion de Residencia
    where  ltrim(rtrim(di_descripcion)) = '0'

  insert into #inf_tabla1
    select
      'Direccion de Residencia Inconsistencias => => '
      + convert(varchar(12), (count(distinct en_ente)+ @w_aux))
    from   #clientesPersonas,
           cobis..cl_direccion
    where  di_ente               = en_ente
       and di_direccion          = en_direccion
       and di_tipo               = '002' ----Direccion de Residencia
       and upper(di_descripcion) = 'MIGRACION'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (6) FORMATO 3 Telefono Residencia'

  insert into #inf_tabla1
    select
      ' TABLA : cl_telefono.te_valor'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
         left join cobis..cl_direccion
                on di_ente = en_ente
                   and di_direccion = en_direccion
                   and di_tipo = '002' ----Direccion de Residencia
         left join cobis..cl_telefono
                on te_ente = di_ente
                   and te_direccion = di_direccion
  where  (te_valor like ('%º%')
       or te_valor like ('%!%')
       or te_valor like ('%"%')
       or te_valor like ('%*%')
       or te_valor like ('%&%')
       or te_valor like ('%|%')
       or te_valor like ('%$%')
       or te_valor like ('%(%')
       or te_valor like ('%;%')
       or te_valor like ('%)%')
       or te_valor like ('%:%')
       or te_valor like ('%[%')
       or te_valor like ('%]%')
       or te_valor like ('%{%')
       or te_valor like ('%}%')
       or te_valor like ('%~%')
       or te_valor like ('%+%')
       or te_valor like ('%¼%')
       or te_valor like ('%@%')
       or te_valor like ('%/%')
       or te_valor like ('%#%')
       or len(te_valor)                 = 1
       or len(replace(te_valor,
                      '0',
                      '')) = 0)

  insert into #inf_tabla1
    select
      'Telefono Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Telefono Vacio => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '002' ----Direccion de Residencia
           left join cobis..cl_telefono
                  on te_ente = di_ente
                     and te_direccion = di_direccion
    where  (ltrim(rtrim(te_valor)) = ''
         or te_valor is null)

  insert into #inf_tabla1
    select
      'Telefono en 0 => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '002'
           left join cobis..cl_telefono
                  on te_ente = di_ente
                     and te_direccion = di_direccion
    where  ltrim(rtrim(te_valor)) = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (7) FORMATO 3 Ocupacion Oficio o profesion'

  insert into #inf_tabla1
    select
      ' TABLA : cl_ente.p_profesion'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  p_profesion like ('%º%')
      or p_profesion like ('%!%')
      or p_profesion like ('%"%')
      or p_profesion like ('%*%')
      or p_profesion like ('%&%')
      or p_profesion like ('%|%')
      or p_profesion like ('%$%')
      or p_profesion like ('%(%')
      or p_profesion like ('%;%')
      or p_profesion like ('%)%')
      or p_profesion like ('%:%')
      or p_profesion like ('%[%')
      or p_profesion like ('%]%')
      or p_profesion like ('%{%')
      or p_profesion like ('%}%')
      or p_profesion like ('%#%')
      or p_profesion like ('%+%')
      or p_profesion like ('%¼%')
      or p_profesion like ('%@%')
      or p_profesion like ('%/%')
      or len(p_profesion) = 1

  insert into #inf_tabla1
    select
      'PROFESION, Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'PROFESION, Vacia => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  p_profesion is null
        or p_profesion = ''

  insert into #inf_tabla1
    select
      'PROFESION, en 0 => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  p_profesion = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (8) FORMATO 3 Actividad '

  insert into #inf_tabla1
    select
      'Campo: cl_ente.en_concordato'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  en_concordato like ('%º%')
      or en_concordato like ('%!%')
      or en_concordato like ('%"%')
      or en_concordato like ('%*%')
      or en_concordato like ('%&%')
      or en_concordato like ('%|%')
      or en_concordato like ('%$%')
      or en_concordato like ('%(%')
      or en_concordato like ('%;%')
      or en_concordato like ('%)%')
      or en_concordato like ('%:%')
      or en_concordato like ('%[%')
      or en_concordato like ('%]%')
      or en_concordato like ('%{%')
      or en_concordato like ('%}%')
      or en_concordato like ('%~%')
      or en_concordato like ('%+%')
      or en_concordato like ('%¼%')
      or en_concordato like ('%@%')
      or en_concordato like ('%/%')
      or en_concordato like ('%#%')
      or len(en_concordato) = 1

  insert into #inf_tabla1
    select
      'OFICIO EN INCONSISTENTE => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'OFICIO EN BLANCO => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  en_concordato is null
        or en_concordato = ''

  insert into #inf_tabla1
    select
      'OFICIO EN CERO => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  en_concordato = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (9) FORMATO 3 Ingresos Mensuales '

  insert into #inf_tabla1
    select
      'Campo: cl_ente.p_nivel_ing'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  ((en_actividad not in ('001002', '001003', '001004')
           and (p_nivel_ing < 10000
                 or p_nivel_ing > 1000000000))
           -- personas asalariadas con ingresos inferiores a 10000
           or (en_actividad in ('001002', '001003', '001004')
               and (p_nivel_ing < 0
                     or p_nivel_ing > 1000000000))
           -- personas no asalariadas con ingresos inferiores a 0
           or not isnumeric(p_nivel_ing) = 1) -- ingresos no numÚricos
     and not p_nivel_ing is null -- lo anterior sin contar los vacios

  insert into #inf_tabla1
    select
      'Ingresos Mensuales Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Ingresos Mensuales Vacio => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesPersonas
    where  p_nivel_ing is null
        or p_nivel_ing = ''
           and p_nivel_ing <> 0

  --insert into #inf_tabla1
  --select  'Ingresos Mensuales en 0' + CONVERT(varchar(12),count(1))
  --from    #clientesPersonas
  --where   p_nivel_ing = 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (10) FORMATO 3 Egresos Mensuales'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.p_nivel_egr'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  p_nivel_egr like ('%º%')
      or p_nivel_egr like ('%!%')
      or p_nivel_egr like ('%"%')
      or p_nivel_egr like ('%*%')
      or p_nivel_egr like ('%&%')
      or p_nivel_egr like ('%|%')
      or p_nivel_egr like ('%$%')
      or p_nivel_egr like ('%(%')
      or p_nivel_egr like ('%;%')
      or p_nivel_egr like ('%)%')
      or p_nivel_egr like ('%:%')
      or p_nivel_egr like ('%[%')
      or p_nivel_egr like ('%]%')
      or p_nivel_egr like ('%{%')
      or p_nivel_egr like ('%}%')
      or p_nivel_egr like ('%~%')
      or p_nivel_egr like ('%+%')
      or p_nivel_egr like ('%¼%')
      or p_nivel_egr like ('%@%')
      or p_nivel_egr like ('%/%')
      or p_nivel_egr like ('%#%')
      or p_nivel_egr <= 0
      or p_nivel_egr > 1000000000

  insert into #inf_tabla1
    select
      'Egresos Mensuales Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Egresos Mensuales Vacio => ' + convert(varchar(12), count(distinct
      en_ente)
      )
    from   #clientesPersonas
    where  p_nivel_egr is null
        or p_nivel_egr = ''
           and p_nivel_egr <> 0

  --insert into #inf_tabla1
  --select  'Egresos Mensuales en 0 ' + convert(varchar(12),count(1))
  --from    #clientesPersonas
  --where   p_nivel_egr = 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (11) FORMATO 3  Otros Ingresos No Operacionales'

  insert into #inf_tabla1
    select
      'Campo: cl_otros_ingresos.oi_descripcion'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas,
         cl_otros_ingresos
  where  oi_ente             = en_ente
     and oi_cod_descripcion  = 'OTR'
     and (oi_descripcion like ('%º%')
           or oi_descripcion like ('%!%')
           or oi_descripcion like ('%"%')
           or oi_descripcion like ('%*%')
           or oi_descripcion like ('%&%')
           or oi_descripcion like ('%|%')
           or oi_descripcion like ('%$%')
           or oi_descripcion like ('%(%')
           or oi_descripcion like ('%;%')
           or oi_descripcion like ('%)%')
           or oi_descripcion like ('%:%')
           or oi_descripcion like ('%[%')
           or oi_descripcion like ('%]%')
           or oi_descripcion like ('%{%')
           or oi_descripcion like ('%}%')
           or oi_descripcion like ('%~%')
           or oi_descripcion like ('%+%')
           or oi_descripcion like ('%¼%')
           or oi_descripcion like ('%@%')
           or oi_descripcion like ('%/%')
           or oi_descripcion like ('%#%')
           or oi_descripcion like ('%0%')
           or oi_descripcion like ('%1%')
           or oi_descripcion like ('%2%')
           or oi_descripcion like ('%3%')
           or oi_descripcion like ('%4%')
           or oi_descripcion like ('%5%')
           or oi_descripcion like ('%6%')
           or oi_descripcion like ('%7%')
           or oi_descripcion like ('%8%')
           or oi_descripcion like ('%9%')
           or len(oi_descripcion) = 1)

  insert into #inf_tabla1
    select
      'Detalle Otros Ingresos Inconsistencias => ' + convert(varchar(12), @w_aux
      )
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Detalle Otros Ingresos Vacio => ' + convert(varchar(12), count(distinct
      en_ente
      ))
    from   #clientesPersonas,
           cl_otros_ingresos
    where  oi_ente            = en_ente
       and oi_cod_descripcion = 'OTR'
       and (oi_descripcion is null
             or oi_descripcion     = '')

  insert into #inf_tabla1
    select
      'Detalle de Otros Ingresos en 0 => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesPersonas,
           cl_otros_ingresos
    where  oi_ente            = en_ente
       and oi_cod_descripcion = 'OTR'
       and oi_descripcion     = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (12) FORMATO 3  Total Activos'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.c_total_activo'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  c_total_activos > 1000000000
      or c_total_activos like ('%º%')
      or c_total_activos like ('%!%')
      or c_total_activos like ('%"%')
      or c_total_activos like ('%*%')
      or c_total_activos like ('%&%')
      or c_total_activos like ('%|%')
      or c_total_activos like ('%$%')
      or c_total_activos like ('%(%')
      or c_total_activos like ('%;%')
      or c_total_activos like ('%)%')
      or c_total_activos like ('%:%')
      or c_total_activos like ('%[%')
      or c_total_activos like ('%]%')
      or c_total_activos like ('%{%')
      or c_total_activos like ('%}%')
      or c_total_activos like ('%~%')
      or c_total_activos like ('%+%')
      or c_total_activos like ('%¼%')
      or c_total_activos like ('%@%')
      or c_total_activos like ('%/%')
      or c_total_activos like ('%#%')
      or c_total_activos <= 0

  insert into #inf_tabla1
    select
      'Total Activos Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Total Activos Vacios => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  convert(varchar(30), c_total_activos) = ''
        or c_total_activos is null

  insert into #inf_tabla1
    select
      '---------------  CAMPO (13) FORMATO 3  Total PAtrimonio'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.en_patrimonio_tec'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  en_patrimonio_tec      > 1000000000
      or en_patrimonio_tec like ('%º%')
      or en_patrimonio_tec like ('%!%')
      or en_patrimonio_tec like ('%"%')
      or en_patrimonio_tec like ('%*%')
      or en_patrimonio_tec like ('%&%')
      or en_patrimonio_tec like ('%|%')
      or en_patrimonio_tec like ('%$%')
      or en_patrimonio_tec like ('%(%')
      or en_patrimonio_tec like ('%;%')
      or en_patrimonio_tec like ('%)%')
      or en_patrimonio_tec like ('%:%')
      or en_patrimonio_tec like ('%[%')
      or en_patrimonio_tec like ('%]%')
      or en_patrimonio_tec like ('%{%')
      or en_patrimonio_tec like ('%}%')
      or en_patrimonio_tec like ('%~%')
      or en_patrimonio_tec like ('%+%')
      or en_patrimonio_tec like ('%¼%')
      or en_patrimonio_tec like ('%@%')
      or en_patrimonio_tec like ('%/%')
      or en_patrimonio_tec like ('%#%')
      or len(en_patrimonio_tec) = 1
      or en_patrimonio_tec      <= 0

  insert into #inf_tabla1
    select
      'Total Patrimonio Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Total Patrimonio Vacio => ' + convert(varchar(12), count(distinct en_ente
      )
      )
    from   #clientesPersonas
    where  en_patrimonio_tec is null
        or convert(varchar(30), en_patrimonio_tec) = ''

  insert into #inf_tabla1
    select
      '---------------  CAMPO (14) FORMATO 3  Total Pasivo'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.c_total_pasivos'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  c_total_pasivos > 1000000000
      or c_total_pasivos like ('%º%')
      or c_total_pasivos like ('%!%')
      or c_total_pasivos like ('%"%')
      or c_total_pasivos like ('%*%')
      or c_total_pasivos like ('%&%')
      or c_total_pasivos like ('%|%')
      or c_total_pasivos like ('%$%')
      or c_total_pasivos like ('%(%')
      or c_total_pasivos like ('%;%')
      or c_total_pasivos like ('%)%')
      or c_total_pasivos like ('%:%')
      or c_total_pasivos like ('%[%')
      or c_total_pasivos like ('%]%')
      or c_total_pasivos like ('%{%')
      or c_total_pasivos like ('%}%')
      or c_total_pasivos like ('%~%')
      or c_total_pasivos like ('%+%')
      or c_total_pasivos like ('%¼%')
      or c_total_pasivos like ('%@%')
      or c_total_pasivos like ('%/%')
      or c_total_pasivos like ('%#%')
      or c_total_pasivos < 0

  insert into #inf_tabla1
    select
      'Total Pasivo Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Total Pasivo Vacios => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  c_total_pasivos is null
        or c_total_pasivos = ''
           and c_total_pasivos <> 0

  insert into #inf_tabla1
    select
'---------------  CAMPO (15) FORMATO 3  Total Operaciones en Moneda Extranjera'
  print ''

  insert into #inf_tabla1
    select
      ' TABLA : cl_relacion_inter.ri_num_producto '

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas,
         cobis..cl_relacion_inter
  where  en_ente = ri_ente
     and (ri_num_producto like ('%º%')
           or ri_num_producto like ('%!%')
           or ri_num_producto like ('%"%')
           or ri_num_producto like ('%*%')
           or ri_num_producto like ('%&%')
           or ri_num_producto like ('%|%')
           or ri_num_producto like ('%$%')
           or ri_num_producto like ('%(%')
           or ri_num_producto like ('%;%')
           or ri_num_producto like ('%)%')
           or ri_num_producto like ('%:%')
           or ri_num_producto like ('%[%')
           or ri_num_producto like ('%]%')
           or ri_num_producto like ('%{%')
           or ri_num_producto like ('%}%')
           or ri_num_producto like ('%~%')
           or ri_num_producto like ('%+%')
           or ri_num_producto like ('%¼%')
           or ri_num_producto like ('%@%')
           or ri_num_producto like ('%/%')
           or ri_num_producto like ('%#%'))

  insert into #inf_tabla1
    select
      'Operacion Moneda Extranjera Inconsistencias => ' + convert(varchar(12),
      @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Operacion Moneda Extranjera Vacio => '
      + convert(varchar(12), count(distinct en_ente))
    from   cobis..cl_relacion_inter,
           #clientesPersonas
    where  en_ente                       = ri_ente
       and (rtrim(ltrim(ri_num_producto)) = ''
             or ri_num_producto is null)

  insert into #inf_tabla1
    select
      'Operacion Moneda Extranjera en 0 => '
      + convert(varchar(12), count(distinct en_ente))
    from   cobis..cl_relacion_inter,
           #clientesPersonas
    where  en_ente                       = ri_ente
       and rtrim(ltrim(ri_num_producto)) = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (16) FORMATO 3  FEcha Diligenciamientoo'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.en_fecha_crea'

  insert into #inf_tabla1
    select
  '----- Validacion de fecha de creacion mayor a la fecha actual o que sea nula'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesPersonas
  where  datepart(yyyy,
                  en_fecha_crea) <= 1990
      or en_fecha_crea                > getdate()

  insert into #inf_tabla1
    select
      'Fecha de Diligenciamiento Inconsistencias => ' + convert(varchar(12),
      @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Fecha de Diligenciamiento Vacias => '
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  en_fecha_crea is null
        or en_fecha_crea = ''

  insert into #inf_tabla1
    select
      'Fecha de Diligenciamiento en 0 => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesPersonas
    where  en_fecha_crea = 0

  select
    @w_total_reg = count(distinct en_ente)
  from   #clientesPersonas

  insert into #inf_tabla1
    select
      char(10) + 'EL NUMERO DE CLIENTES ACTIVOS TIPO PERSONA ES => '
      + cast(@w_total_reg as varchar)

  select
    @w_total_reg = @w_total_reg * @w_variables

  insert into #inf_tabla1
    select
      char(10) + 'EL NUMERO TOTAL DE REGISTROS PARA PERSONAS ES => '
      + cast(@w_total_reg as varchar) + char(10)

  insert into #inf_tabla1
    select
      'CLIENTES DESACTUALIZADOS TIPO PERSONA =>'
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  en_fecha_mod <= dateadd(yyyy,
                                   -1,
                                   @w_fecha_rep)

  insert into #inf_tabla1
    select
      char(10) + 'EL NUMERO TOTAL DE INCONSISTENCIAS ES => '
      + cast(@w_inconsistencias as varchar)

  insert into #inf_tabla1
    select
'CLIENTES ACTIVOS DESACTIALIZADOS TIPO PERSONA POR DEUDOR PPAL - ACTIVAS, CODEUDOR - ACTIVAS  =>'
+ convert(varchar(12), count(distinct en_ente))
from   #clientesPersonas
where  en_fecha_mod <= dateadd(yyyy,
                               -1,
                               @w_fecha_rep)
   and ROL in ('DEUDOR PPAL - ACTIVAS', 'CODEUDOR - ACTIVAS')

  insert into #inf_tabla1
    select
      'CLIENTES PASIVOS DESACTUALIZADOS TIPO PERSONA POR TITULAR - PASIVAS  =>'
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesPersonas
    where  en_fecha_mod <= dateadd(yyyy,
                                   -1,
                                   @w_fecha_rep)
       and ROL in ('TITULAR - PASIVAS')

  /** paso 3 **/
  select
    @w_variables = 0,
    @w_inconsistencias = 0

  select
    *
  into   #clientesCompanias
  from   cobis..cl_ente,
         cob_conta_super..sb_cliente_dato_sfc
  where  en_ente    = cliente_u
     and en_subtipo = 'C'

  insert into #inf_tabla1
    select
      'CAntidad   PERSONA JURIDICA  => ' + convert(varchar(12), count(distinct
      en_ente
      ))
    from   #clientesCompanias

  insert into #inf_tabla1
    select
      '---------------  CAMPO (1) FORMATO 3 Razon Social'

  insert into #inf_tabla1
    select
      'CAMPO:cl_ente.en_nomlar '

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  en_nomlar like ('%º%')
      or en_nomlar like ('%!%')
      or en_nomlar like ('%"%')
      or en_nomlar like ('%*%')
      or en_nomlar like ('%&%')
      or en_nomlar like ('%|%')
      or en_nomlar like ('%$%')
      or en_nomlar like ('%(%')
      or en_nomlar like ('%;%')
      or en_nomlar like ('%)%')
      or en_nomlar like ('%:%')
      or en_nomlar like ('%[%')
      or en_nomlar like ('%]%')
      or en_nomlar like ('%{%')
      or en_nomlar like ('%}%')
      or en_nomlar like ('%~%')
      or en_nomlar like ('%+%')
      or en_nomlar like ('%¼%')
      or en_nomlar like ('%@%')
      or en_nomlar like ('%#%')
      or en_nomlar like ('%0%')
      or en_nomlar like ('%1%')
      or en_nomlar like ('%2%')
      or en_nomlar like ('%3%')
      or en_nomlar like ('%4%')
      or en_nomlar like ('%5%')
      or en_nomlar like ('%6%')
      or en_nomlar like ('%7%')
      or en_nomlar like ('%8%')
      or en_nomlar like ('%9%')
      or len(en_nomlar) = 1

  insert into #inf_tabla1
    select
      'en_nomlar con Inconcistencias  => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'en_nomlar Vacio  => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  ltrim(rtrim(en_nomlar)) = ''
        or en_nomlar is null

  insert into #inf_tabla1
    select
      'en_nomlar en 0  => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_nomlar = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (2) FORMATO 3 NIT'

  insert into #inf_tabla1
    select
      'CAMPO: cl_ente.en_ced_ruc '

  insert into #inf_tabla1
    select
      '----- Validacion de NIT'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  en_ced_ruc like ('%º%')
      or en_ced_ruc like ('%!%')
      or en_ced_ruc like ('%"%')
      or en_ced_ruc like ('%*%')
      or en_ced_ruc like ('%&%')
      or en_ced_ruc like ('%|%')
      or en_ced_ruc like ('%$%')
      or en_ced_ruc like ('%(%')
      or en_ced_ruc like ('%;%')
      or en_ced_ruc like ('%)%')
      or en_ced_ruc like ('%:%')
      or en_ced_ruc like ('%[%')
      or en_ced_ruc like ('%]%')
      or en_ced_ruc like ('%{%')
      or en_ced_ruc like ('%}%')
      or en_ced_ruc like ('%~%')
      or en_ced_ruc like ('%+%')
      or en_ced_ruc like ('%¼%')
      or en_ced_ruc like ('%@%')
      or en_ced_ruc like ('%#%')
      or len(en_ced_ruc)                 = 1
      or len(replace(en_ced_ruc,
                     '0',
                     '')) = 0

  insert into #inf_tabla1
    select
      'Numero NIT Con inconsistencias  => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Numero NIT en Vacio  => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_ced_ruc is null
        or en_ced_ruc = ''

  insert into #inf_tabla1
    select
      'Numero NIT en 0  => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_ced_ruc = '0'

  insert into #inf_tabla1
    select
      '----- Validacion de NIT duplicadas.'
  --Este script crea Tablas temporales'

  insert into #inf_tabla1
    select
      'Numero NIT Duplicados  => ' + convert(varchar(12), count(1))
    from   #clientesCompanias
    group  by en_ced_ruc
    having count(distinct en_ced_ruc) > 1

  select
    'No_Ident' = en_ced_ruc,
    'Tipo_ced' = en_tipo_ced,
    'Cant' = count(distinct en_ente)
  into   #cedrep1 -- Codigos de  numeros de documentos  repetidas
  from   #clientesCompanias
  group  by en_ced_ruc,
            en_tipo_ced
  having count(en_ced_ruc) > 1
  ---------------------------------------------------------------------------------validar

  select
    ente = en_ente,
    cedula = en_ced_ruc
  into   #enterep1
  -- codigos de los entes que estan con numeros de documentos repetidos
  from   cobis..cl_ente,
         #cedrep1
  where  en_ced_ruc = No_Ident

  insert into #inf_tabla1
    select
'---------------  CAMPO (3) FORMATO 3 Nombre-Apellido-cedula del representante legal'

  select
    @w_variables = @w_variables + 1

  insert into #inf_tabla1
    select
' TABLA : cl_ente.en_nomlar cruce con cl_instancia  por la relacion 205 Representante legal'

  select
    @w_aux = count(distinct CLI.en_ente)
  from   #clientesCompanias as CLI
         left join cl_instancia as INS
                on INS.in_ente_d = CLI.en_ente
         left join cl_ente as REP
                on INS.in_ente_i = REP.en_ente
                   and INS.in_relacion = 205
  where  --in_lado like '%'     
    (REP.en_nomlar like ('%º%')
  or REP.en_nomlar like ('%!%')
  or REP.en_nomlar like ('%"%')
  or REP.en_nomlar like ('%*%')
  or REP.en_nomlar like ('%&%')
  or REP.en_nomlar like ('%|%')
  or REP.en_nomlar like ('%$%')
  or REP.en_nomlar like ('%(%')
  or REP.en_nomlar like ('%;%')
  or REP.en_nomlar like ('%)%')
  or REP.en_nomlar like ('%:%')
  or REP.en_nomlar like ('%[%')
  or REP.en_nomlar like ('%]%')
  or REP.en_nomlar like ('%{%')
  or REP.en_nomlar like ('%}%')
  or REP.en_nomlar like ('%~%')
  or REP.en_nomlar like ('%+%')
  or REP.en_nomlar like ('%¼%')
  or REP.en_nomlar like ('%@%')
  or REP.en_nomlar like ('%#%')
  or len(replace(REP.en_nomlar,
                 '0',
                 '')) = 0
  or len(REP.en_nomlar)                 = 1
  or REP.en_ced_ruc like ('%º%')
  or REP.en_ced_ruc like ('%!%')
  or len(REP.en_nomlar)                 = 1
  or REP.en_ced_ruc like ('%"%')
  or REP.en_ced_ruc like ('%*%')
  or REP.en_ced_ruc like ('%&%')
  or REP.en_ced_ruc like ('%|%')
  or REP.en_ced_ruc like ('%$%')
  or REP.en_ced_ruc like ('%(%')
  or REP.en_ced_ruc like ('%;%')
  or REP.en_ced_ruc like ('%)%')
  or REP.en_ced_ruc like ('%:%')
  or REP.en_ced_ruc like ('%[%')
  or REP.en_ced_ruc like ('%]%')
  or REP.en_ced_ruc like ('%{%')
  or REP.en_ced_ruc like ('%}%')
  or REP.en_ced_ruc like ('%~%')
  or REP.en_ced_ruc like ('%+%')
  or REP.en_ced_ruc like ('%¼%')
  or REP.en_ced_ruc like ('%@%')
  or REP.en_ced_ruc like ('%#%')
  or len(replace(REP.en_nomlar,
                 '0',
                 '')) = 0)

  insert into #inf_tabla1
    select
      'Representante legal Inconsistentes  => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Representante legal con Datos Vacios  => '
      + convert(varchar(12), count(distinct UNI.en_ente))
    from   #clientesCompanias as UNI
           left join (select
                        CLI.en_ente,REP.en_ente
                        as en_ente_II,REP.en_nomlar
                        as
                        en_nomlar_II,
                        REP.en_ced_ruc as en_ced_ruc_II
                      from   cl_ente as CLI
                             left join cl_instancia as INS
                                    on INS.in_ente_d = CLI.en_ente
                             left join cl_ente as REP
                                    on INS.in_ente_i = REP.en_ente
                      where  INS.in_relacion = 205) as CLI
                  on CLI.en_ente = UNI.en_ente
    where  CLI.en_ced_ruc_II = ''
        or CLI.en_ced_ruc_II is null
        or CLI.en_nomlar_II  = ''
        or CLI.en_nomlar_II is null

  insert into #inf_tabla1
    select
      'Representante legal con 0  => ' + convert(varchar(12), count(distinct
      CLI.en_ente))
    from   #clientesCompanias as CLI
           left join cl_instancia as INS
                  on INS.in_ente_d = CLI.en_ente
           left join cl_ente as REP
                  on INS.in_ente_i = REP.en_ente
                     and INS.in_relacion = 205
    where  REP.en_ente = 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (4) FORMATO 3  Telefono del representante legal'

  insert into #inf_tabla1
    select
  ' TABLA : cl_telefono.te_valor cruce con cl_instancia relacion 2050 Rep Legal'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct UNI.en_ente)
  from   #clientesCompanias as UNI
         left join (select
                      CLI.en_ente,
                      REP.en_ente      as en_ente_II,
                      REP.en_nomlar    as en_nomlar_II,
                      REP.en_ced_ruc   as en_ced_ruc_II,
                      REP.en_direccion as en_direccion_II
                    from   cl_ente as CLI
                           left join cl_instancia as INS
                                  on INS.in_ente_d = CLI.en_ente
                           left join cl_ente as REP
                                  on INS.in_ente_i = REP.en_ente
                    where  INS.in_relacion = 205) as CLI
                on CLI.en_ente = UNI.en_ente
         left join cobis..cl_telefono as TEL
                on te_ente = CLI.en_ente
  where  (te_valor like ('%º%')
       or te_valor like ('%!%')
       or te_valor like ('%"%')
       or te_valor like ('%*%')
       or te_valor like ('%&%')
       or te_valor like ('%|%')
       or te_valor like ('%$%')
       or te_valor like ('%(%')
       or te_valor like ('%;%')
       or te_valor like ('%)%')
       or te_valor like ('%:%')
       or te_valor like ('%[%')
       or te_valor like ('%]%')
       or te_valor like ('%{%')
       or te_valor like ('%}%')
       or te_valor like ('%~%')
       or te_valor like ('%+%')
       or te_valor like ('%¼%')
       or te_valor like ('%@%')
       or te_valor like ('%/%')
       or te_valor like ('%#%')
       or len(te_valor)                 = 1
       or len(replace(te_valor,
                      '0',
                      '')) = 0
       or len(replace(te_valor,
                      '9',
                      '')) = 0)

  insert into #inf_tabla1
    select
      'Telefono Rep Legal Inconsistencias  => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Telefono Rep Legal Vacio  => ' + convert(varchar(12), count(distinct
      UNI.en_ente))
    from   #clientesCompanias as UNI
           left join (select
                        CLI.en_ente,REP.en_ente
                        as en_ente_II,REP.en_nomlar
                        as en_nomlar_II,REP.en_ced_ruc
                        as
                        en_ced_ruc_II,REP.en_direccion as en_direccion_II
                      from   cl_ente as CLI
                             left join cl_instancia as INS
                                    on INS.in_ente_d = CLI.en_ente
                             left join cl_ente as REP
                                    on INS.in_ente_i = REP.en_ente
                      where  INS.in_relacion = 205) as CLI
                  on CLI.en_ente = UNI.en_ente
           left join cobis..cl_telefono as TEL
                  on te_ente = CLI.en_ente
    where  te_valor is null
        or te_valor = ''

  insert into #inf_tabla1
    select
      'Telefono Rep Legal Con 0  => ' + convert(varchar(12), count(distinct
      UNI.en_ente))
    from   #clientesCompanias as UNI
           left join (select
                        CLI.en_ente,REP.en_ente
                        as en_ente_II,REP.en_nomlar
                        as en_nomlar_II,REP.en_ced_ruc
                        as
                        en_ced_ruc_II,REP.en_direccion as en_direccion_II
                      from   cl_ente as CLI
                             left join cl_instancia as INS
                                    on INS.in_ente_d = CLI.en_ente
                             left join cl_ente as REP
                                    on INS.in_ente_i = REP.en_ente
                      where  INS.in_relacion = 205) as CLI
                  on CLI.en_ente = UNI.en_ente
           left join cobis..cl_telefono as TEL
                  on te_ente = CLI.en_ente
    where  te_valor = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (5) FORMATO 3  Actividad Economica '

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  en_actividad like ('%º%')
      or en_actividad like ('%!%')
      or en_actividad like ('%"%')
      or en_actividad like ('%*%')
      or en_actividad like ('%&%')
      or en_actividad like ('%|%')
      or en_actividad like ('%$%')
      or en_actividad like ('%(%')
      or en_actividad like ('%;%')
      or en_actividad like ('%)%')
      or en_actividad like ('%:%')
      or en_actividad like ('%[%')
      or en_actividad like ('%]%')
      or en_actividad like ('%{%')
      or en_actividad like ('%}%')
      or en_actividad like ('%~%')
      or en_actividad like ('%+%')
      or en_actividad like ('%¼%')
      or en_actividad like ('%@%')
      or en_actividad like ('%/%')
      or en_actividad like ('%#%')
      or len(en_actividad) = 1

  insert into #inf_tabla1
    select
      'Actividad Inconsistencias  => ' + convert(varchar(12), @w_aux)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Actividad Vacio  => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_actividad is null
        or en_actividad = ''

  insert into #inf_tabla1
    select
      'Actividad en 0  => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_actividad = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (6) FORMATO 3  Direccionde de la oficina ppal'

  insert into #inf_tabla1
    select
      'Campo: cl_direccion.di_descripcion'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
         left join cobis..cl_direccion
                on di_ente = en_ente
                   and di_direccion = en_direccion
                   and di_tipo = '003'
  where  (di_descripcion like ('%º%')
       or di_descripcion like ('%!%')
       or di_descripcion like ('%"%')
       or di_descripcion like ('%*%')
       or di_descripcion like ('%&%')
       or di_descripcion like ('%|%')
       or di_descripcion like ('%$%')
       or di_descripcion like ('%(%')
       or di_descripcion like ('%;%')
       or di_descripcion like ('%)%')
       or di_descripcion like ('%:%')
       or di_descripcion like ('%[%')
       or di_descripcion like ('%]%')
       or di_descripcion like ('%{%')
       or di_descripcion like ('%}%')
       or di_descripcion like ('%=%')
       or di_descripcion like ('%+%')
       or di_descripcion like ('%¼%')
       or di_descripcion like ('%@%')
       or di_descripcion like ('%/%')
       or len(di_descripcion) = 1)

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Direccion de Negocio Vacio  => ' + convert(varchar(12), count(distinct
      en_ente)
      )
    from   #clientesCompanias
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '003'
    where  (ltrim(rtrim(di_descripcion)) = ''
         or di_descripcion is null)

  insert into #inf_tabla1
    select
      'Direccion de Negocio en 0  => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesCompanias
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '003'
    where  ltrim(rtrim(di_descripcion)) = '0'

  insert into #inf_tabla1
    select
      'Direccion de Negocio Inconsistencias  => '
      + convert(varchar(12), count(distinct en_ente)+@w_aux)
    from   #clientesCompanias
           left join cobis..cl_direccion
                  on di_ente = en_ente
                     and di_direccion = en_direccion
                     and di_tipo = '003' ----Direccion de Residencia
    where  upper(di_descripcion) = 'MIGRACION'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (7) FORMATO 3 Ciudad OFicina ppal'

  select
    @w_variables = @w_variables + 1

  insert into #inf_tabla1
    select
      'Campo: cl_ente.c_ciudad'

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
         left join (select
                      ci_ciudad,
                      di_direccion,
                      ci_descripcion,
                      di_ente
                    from   cobis..cl_ciudad
                           inner join cl_direccion
                                   on di_ciudad = ci_ciudad
                    where  di_tipo = '003') as DIR
                on en_ente = di_ente
                   and di_direccion = en_direccion
  where  c_ciudad like ('%º%')
      or c_ciudad like ('%!%')
      or c_ciudad like ('%"%')
      or c_ciudad like ('%*%')
      or c_ciudad like ('%&%')
      or c_ciudad like ('%|%')
      or c_ciudad like ('%$%')
      or c_ciudad like ('%(%')
      or c_ciudad like ('%;%')
      or c_ciudad like ('%)%')
      or c_ciudad like ('%:%')
      or c_ciudad like ('%[%')
      or c_ciudad like ('%]%')
      or c_ciudad like ('%{%')
      or c_ciudad like ('%}%')
      or c_ciudad like ('%=%')
      or c_ciudad like ('%+%')
      or c_ciudad like ('%¼%')
      or c_ciudad like ('%@%')
      or c_ciudad like ('%/%')
      or len(c_ciudad) = 1

  insert into #inf_tabla1
    select
      'Ciudad Oficina Principal Inconsistente  => ' + convert(varchar(12),
      @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Ciudad Oficina Principal Vacia  => '
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
           left join (select
                        ci_ciudad,di_direccion,ci_descripcion,di_ente
                      from   cobis..cl_ciudad
                             inner join cl_direccion
                                     on di_ciudad = ci_ciudad
                      where  di_tipo = '003') as DIR
                  on en_ente = di_ente
                     and di_direccion = en_direccion
    where  ci_ciudad is null
        or ci_ciudad = ''

  insert into #inf_tabla1
    select
      'Ciudad Oficina Principal en 0  => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesCompanias
           left join (select
                        ci_ciudad,di_direccion,ci_descripcion,di_ente
                      from   cobis..cl_ciudad
                             inner join cl_direccion
                                     on di_ciudad = ci_ciudad
                      where  di_tipo = '003') as DIR
                  on en_ente = di_ente
                     and di_direccion = en_direccion
    where  ci_ciudad = 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (8) FORMATO 3 telefono oficina ppal'

  insert into #inf_tabla1
    select
      'Campo: cl_telefono.te_valor'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
         left join cobis..cl_telefono
                on te_ente = en_ente
  where  (te_valor like ('%º%')
       or te_valor like ('%!%')
       or te_valor like ('%"%')
       or te_valor like ('%*%')
       or te_valor like ('%&%')
       or te_valor like ('%|%')
       or te_valor like ('%$%')
       or te_valor like ('%(%')
       or te_valor like ('%;%')
       or te_valor like ('%)%')
       or te_valor like ('%:%')
       or te_valor like ('%[%')
       or te_valor like ('%]%')
       or te_valor like ('%{%')
       or te_valor like ('%}%')
       or te_valor like ('%~%')
       or te_valor like ('%+%')
       or te_valor like ('%¼%')
       or te_valor like ('%@%')
       or te_valor like ('%/%')
       or te_valor like ('%#%')
       or len(te_valor)                 = 1
       or len(replace(te_valor,
                      '0',
                      '')) = 0)

  insert into #inf_tabla1
    select
      'Telefono Ofi Ppal Inconsistencias  => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Telefono Ofi Ppal Vacio  => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesCompanias
           left join cobis..cl_telefono
                  on te_ente = en_ente
    where  (te_valor = ''
         or te_valor is null)

  insert into #inf_tabla1
    select
      'Telefono Ofi Ppal en 0  => ' + convert(varchar(12), count(distinct
      en_ente)
      )
    from   #clientesCompanias
           left join cobis..cl_telefono
                  on te_ente = en_ente
    where  te_valor = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (9) FORMATO 3 fax oficina ppal '

  select
    @w_variables = @w_variables + 1

  insert into #inf_tabla1
    select
      'Catalogo 2178'

  insert into #inf_tabla1
    select
      convert(varchar(16), codigo) + convert(varchar(16), valor)
    from   cobis..cl_catalogo
    where  tabla = 2178

  insert into #inf_tabla1
    select
      'Campo: cl_telefono.te_valor para FAX '

  select
    @w_aux = count(distinct en_ente)
  from   cobis..cl_direccion,
         cobis..cl_telefono,
         #clientesCompanias
  where  di_oficina       = en_oficina
     and di_ente          = en_ente
     and di_ente          = te_ente
     and te_ente          = en_ente
     and di_direccion     = te_direccion
     and te_tipo_telefono = 'F' --FAX
     and (te_valor like ('%º%')
           or te_valor like ('%!%')
           or te_valor like ('%"%')
           or te_valor like ('%*%')
           or te_valor like ('%&%')
           or te_valor like ('%|%')
           or te_valor like ('%$%')
           or te_valor like ('%(%')
           or te_valor like ('%;%')
           or te_valor like ('%)%')
           or te_valor like ('%:%')
           or te_valor like ('%[%')
           or te_valor like ('%]%')
           or te_valor like ('%{%')
           or te_valor like ('%}%')
           or te_valor like ('%~%')
           or te_valor like ('%+%')
           or te_valor like ('%¼%')
           or te_valor like ('%@%')
           or te_valor like ('%/%')
           or te_valor like ('%#%')
           or len(te_valor)    = 1
           or te_valor         = '0000000')

  insert into #inf_tabla1
    select
      'Telefono OFi. ppal FAX  => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Telefono OFi. ppal  FAX en vacio  => '
      + convert(varchar(12), count(distinct en_ente))
    from   cobis..cl_direccion,
           cobis..cl_telefono,
           #clientesCompanias
    where  di_oficina       = en_oficina
       and di_ente          = en_ente
       and di_ente          = te_ente
       and te_ente          = en_ente
       and di_direccion     = te_direccion
       and te_tipo_telefono = 'F' --FAX
       and (te_valor         = ''
             or te_valor is null)

  insert into #inf_tabla1
    select
      'Telefono OFi. ppal  FAX en 0  => ' + convert(varchar(12), count(distinct
      en_ente))
    from   cobis..cl_direccion,
           cobis..cl_telefono,
           #clientesCompanias
    where  di_oficina       = en_oficina
       and di_ente          = en_ente
       and di_ente          = te_ente
       and te_ente          = en_ente
       and di_direccion     = te_direccion
       and te_tipo_telefono = 'F' --FAX
       and te_valor         = '0'

  insert into #inf_tabla1
    select
'---------------  CAMPO (10 y 11) FORMATO 3 Identificacion de accionistas mas 5% '

  insert into #inf_tabla1
    select
'TABLAS:cl_at_instancia -  cl_instancia validacion  - cl_ente cl_ente.en_ced_ruc  relacion 201 - 202 accionistas'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct A.en_ente)
  from   cl_at_instancia ai1,
         #clientesCompanias A,
         cl_at_instancia ai2,
         cl_at_instancia ai3,
         cl_instancia,
         cl_ente CL
  where  ai1.ai_ente_i                      = A.en_ente
     and ai2.ai_ente_i                      = A.en_ente
     and ai3.ai_ente_i                      = A.en_ente
     and ai1.ai_ente_i                      = in_ente_i
     and ai1.ai_relacion                    = in_relacion
     and (in_relacion                        = 201
           or in_relacion                        = 202)
     and (ai1.ai_relacion                    = 201
           or ai1.ai_relacion                    = 202)
     and ai2.ai_relacion                    = ai1.ai_relacion
     and ai3.ai_relacion                    = ai1.ai_relacion
     and (in_lado = 'D')
     and ai1.ai_atributo                    = 1
     and ai2.ai_atributo                    = 2
     and ai3.ai_atributo                    = 3
     and in_ente_d                          = CL.en_ente
     and ai1.ai_ente_d                      = CL.en_ente
     and ai1.ai_ente_d                      = ai2.ai_ente_d
     and ai1.ai_ente_d                      = ai3.ai_ente_d
     and len(CL.en_ced_ruc)                 = 1
     and (CL.en_ced_ruc like ('%º%')
           or CL.en_ced_ruc like ('%!%')
           or CL.en_ced_ruc like ('%"%')
           or CL.en_ced_ruc like ('%*%')
           or CL.en_ced_ruc like ('%&%')
           or CL.en_ced_ruc like ('%|%')
           or CL.en_ced_ruc like ('%$%')
           or CL.en_ced_ruc like ('%(%')
           or CL.en_ced_ruc like ('%;%')
           or CL.en_ced_ruc like ('%)%')
           or CL.en_ced_ruc like ('%:%')
           or CL.en_ced_ruc like ('%[%')
           or CL.en_ced_ruc like ('%]%')
           or CL.en_ced_ruc like ('%{%')
           or CL.en_ced_ruc like ('%}%')
           or CL.en_ced_ruc like ('%~%')
           or CL.en_ced_ruc like ('%+%')
           or CL.en_ced_ruc like ('%¼%')
           or CL.en_ced_ruc like ('%@%')
           or CL.en_ced_ruc like ('%/%')
           or CL.en_ced_ruc like ('%#%')
           or len(CL.en_ced_ruc)                 = 1
           or len(replace(CL.en_ced_ruc,
                          '0',
                          '')) = 0)

  insert into #inf_tabla1
    select
      'Identificacion Accionistas Inconsistencias => ' + convert(varchar(12),
      @w_aux
      )

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Identificacion Accionistas Vacio => '
      + convert(varchar(12), count(distinct A.en_ente))
    from   cl_at_instancia ai1,
           #clientesCompanias A,
           cl_at_instancia ai2,
           cl_at_instancia ai3,
           cl_instancia,
           cl_ente CL
    where  ai1.ai_ente_i   = A.en_ente
       and ai2.ai_ente_i   = A.en_ente
       and ai3.ai_ente_i   = A.en_ente
       and ai1.ai_ente_i   = in_ente_i
       and ai1.ai_relacion = in_relacion
       and (in_relacion     = 201
             or in_relacion     = 202)
       and (ai1.ai_relacion = 201
             or ai1.ai_relacion = 202)
       and ai2.ai_relacion = ai1.ai_relacion
       and ai3.ai_relacion = ai1.ai_relacion
       and (in_lado = 'D')
       and ai1.ai_atributo = 1
       and ai2.ai_atributo = 2
       and ai3.ai_atributo = 3
       and in_ente_d       = CL.en_ente
       and ai1.ai_ente_d   = CL.en_ente
       and ai1.ai_ente_d   = ai2.ai_ente_d
       and ai1.ai_ente_d   = ai3.ai_ente_d
       and (CL.en_ced_ruc is null
             or CL.en_ced_ruc   = '')

  insert into #inf_tabla1
    select
      'Identificacion Accionistas en 0 => '
      + convert(varchar(12), count(distinct A.en_ente))
    from   cl_at_instancia ai1,
           #clientesCompanias A,
           cl_at_instancia ai2,
           cl_at_instancia ai3,
           cl_instancia,
           cl_ente CL
    where  ai1.ai_ente_i   = A.en_ente
       and ai2.ai_ente_i   = A.en_ente
       and ai3.ai_ente_i   = A.en_ente
       and ai1.ai_ente_i   = in_ente_i
       and ai1.ai_relacion = in_relacion
       and (in_relacion     = 201
             or in_relacion     = 202)
       and (ai1.ai_relacion = 201
             or ai1.ai_relacion = 202)
       and ai2.ai_relacion = ai1.ai_relacion
       and ai3.ai_relacion = ai1.ai_relacion
       and (in_lado = 'D')
       and ai1.ai_atributo = 1
       and ai2.ai_atributo = 2
       and ai3.ai_atributo = 3
       and in_ente_d       = CL.en_ente
       and ai1.ai_ente_d   = CL.en_ente
       and ai1.ai_ente_d   = ai2.ai_ente_d
       and ai1.ai_ente_d   = ai3.ai_ente_d
       and CL.en_ced_ruc   = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (12) FORMATO 3 Tipode Empresa'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.c_tipo_compania'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  c_tipo_compania not in (select
                                   c.codigo
                                 from   cobis..cl_catalogo c,
                                        cobis..cl_tabla t
                                 where  t.tabla  = 'cl_tip_soc'
                                    and t.codigo = c.tabla)
     and (c_tipo_compania like ('%º%')
           or c_tipo_compania like ('%!%')
           or c_tipo_compania like ('%"%')
           or c_tipo_compania like ('%*%')
           or c_tipo_compania like ('%&%')
           or c_tipo_compania like ('%|%')
           or c_tipo_compania like ('%$%')
           or c_tipo_compania like ('%(%')
           or c_tipo_compania like ('%;%')
           or c_tipo_compania like ('%)%')
           or c_tipo_compania like ('%:%')
           or c_tipo_compania like ('%[%')
           or c_tipo_compania like ('%]%')
           or c_tipo_compania like ('%{%')
           or c_tipo_compania like ('%}%')
           or c_tipo_compania like ('%~%')
           or c_tipo_compania like ('%+%')
           or c_tipo_compania like ('%¼%')
           or c_tipo_compania like ('%@%')
           or c_tipo_compania like ('%/%')
           or c_tipo_compania like ('%#%')
           or len(c_tipo_compania) = 1)
      or (rtrim(ltrim(c_tipo_compania)) <> 'OF')
         and (rtrim(ltrim(c_tipo_compania)) <> 'PA')

  insert into #inf_tabla1
    select
      'Tipo Empresa Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Tipo Empresa con Vacio => ' + convert(varchar(12), count(distinct en_ente
      )
      )
    from   #clientesCompanias
    where  c_tipo_compania is null
        or c_tipo_compania = ''

  insert into #inf_tabla1
    select
      'Tipo Empresa con 0 => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  c_tipo_compania = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (13) FORMATO 3 Ingresos Mensuales'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.p_nivel_ing'

  insert into #inf_tabla1
    select
      '----- Validacion de Ingresos'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  (p_nivel_ing like ('%º%')
           or p_nivel_ing like ('%!%')
           or p_nivel_ing like ('%"%')
           or p_nivel_ing like ('%*%')
           or p_nivel_ing like ('%&%')
           or p_nivel_ing like ('%|%')
           or p_nivel_ing like ('%$%')
           or p_nivel_ing like ('%(%')
           or p_nivel_ing like ('%;%')
           or p_nivel_ing like ('%)%')
           or p_nivel_ing like ('%:%')
           or p_nivel_ing like ('%[%')
           or p_nivel_ing like ('%]%')
           or p_nivel_ing like ('%{%')
           or p_nivel_ing like ('%}%')
           or p_nivel_ing like ('%~%')
           or p_nivel_ing like ('%+%')
           or p_nivel_ing like ('%¼%')
           or p_nivel_ing like ('%@%')
           or p_nivel_ing like ('%/%')
           or p_nivel_ing like ('%#%'))
      or p_nivel_ing <= 0

  insert into #inf_tabla1
    select
      'Ingresos Mensuales Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Ingresos Mensuales Vacio => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesCompanias
    where  p_nivel_ing is null
        or p_nivel_ing = ''
           and p_nivel_ing <> 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (14) FORMATO 3 Egresos Mensuales'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.p_nivel_egr'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  p_nivel_egr like ('%º%')
      or p_nivel_egr like ('%!%')
      or p_nivel_egr like ('%"%')
      or p_nivel_egr like ('%*%')
      or p_nivel_egr like ('%&%')
      or p_nivel_egr like ('%|%')
      or p_nivel_egr like ('%$%')
      or p_nivel_egr like ('%(%')
      or p_nivel_egr like ('%;%')
      or p_nivel_egr like ('%)%')
      or p_nivel_egr like ('%:%')
      or p_nivel_egr like ('%[%')
      or p_nivel_egr like ('%]%')
      or p_nivel_egr like ('%{%')
      or p_nivel_egr like ('%}%')
      or p_nivel_egr like ('%~%')
      or p_nivel_egr like ('%+%')
      or p_nivel_egr like ('%¼%')
      or p_nivel_egr like ('%@%')
      or p_nivel_egr like ('%/%')
      or p_nivel_egr like ('%#%')
      or len(p_nivel_egr) = 1
      or p_nivel_egr      <= 0
      or p_nivel_egr      > 1000000000

  insert into #inf_tabla1
    select
      'Egresos Mensuales Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Ingresos Mensuales Vacio => ' + convert(varchar(12), count(distinct
      en_ente
      )
      )
    from   #clientesCompanias
    where  p_nivel_egr is null
        or p_nivel_egr = ''
           and p_nivel_egr <> 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (15) FORMATO 3  Otros Ingresos No Operacionales '

  insert into #inf_tabla1
    select
      'Campo: cl_otros_ingresos.oi_valor'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias,
         cl_otros_ingresos
  where  oi_ente             = en_ente
     and oi_cod_descripcion  = 'OTR'
     and (oi_descripcion like ('%º%')
           or oi_descripcion like ('%!%')
           or oi_descripcion like ('%"%')
           or oi_descripcion like ('%*%')
           or oi_descripcion like ('%&%')
           or oi_descripcion like ('%|%')
           or oi_descripcion like ('%$%')
           or oi_descripcion like ('%(%')
           or oi_descripcion like ('%;%')
           or oi_descripcion like ('%)%')
           or oi_descripcion like ('%:%')
           or oi_descripcion like ('%[%')
           or oi_descripcion like ('%]%')
           or oi_descripcion like ('%{%')
           or oi_descripcion like ('%}%')
           or oi_descripcion like ('%~%')
           or oi_descripcion like ('%+%')
           or oi_descripcion like ('%¼%')
           or oi_descripcion like ('%@%')
           or oi_descripcion like ('%/%')
           or oi_descripcion like ('%#%')
           or oi_descripcion like ('%0%')
           or oi_descripcion like ('%1%')
           or oi_descripcion like ('%2%')
           or oi_descripcion like ('%3%')
           or oi_descripcion like ('%4%')
           or oi_descripcion like ('%5%')
           or oi_descripcion like ('%6%')
           or oi_descripcion like ('%7%')
           or oi_descripcion like ('%8%')
           or oi_descripcion like ('%9%')
           or len(oi_descripcion) = 1)

  insert into #inf_tabla1
    select
      'Detalle Otros Ingresos Inconsistencias => ' + convert(varchar(12), @w_aux
      )

  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Detalle Otros Ingresos Vacio => ' + convert(varchar(12), count(distinct
      en_ente
      ))
    from   #clientesCompanias,
           cl_otros_ingresos
    where  oi_ente            = en_ente
       and oi_cod_descripcion = 'OTR'
       and (oi_descripcion is null
             or oi_descripcion     = '')

  insert into #inf_tabla1
    select
      'Detalle de Otros Ingresos en 0 => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesCompanias,
           cl_otros_ingresos
    where  oi_ente            = en_ente
       and oi_cod_descripcion = 'OTR'
       and oi_descripcion     = '0'

  insert into #inf_tabla1
    select
      '---------------  CAMPO (16) FORMATO 3  Total Activos'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.c_total_activo'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  -- c_total_activos > 1000000000
    c_total_activos like ('%º%')
  or c_total_activos like ('%!%')
  or c_total_activos like ('%"%')
  or c_total_activos like ('%*%')
  or c_total_activos like ('%&%')
  or c_total_activos like ('%|%')
  or c_total_activos like ('%$%')
  or c_total_activos like ('%(%')
  or c_total_activos like ('%;%')
  or c_total_activos like ('%)%')
  or c_total_activos like ('%:%')
  or c_total_activos like ('%[%')
  or c_total_activos like ('%]%')
  or c_total_activos like ('%{%')
  or c_total_activos like ('%}%')
  or c_total_activos like ('%~%')
  or c_total_activos like ('%+%')
  or c_total_activos like ('%¼%')
  or c_total_activos like ('%@%')
  or c_total_activos like ('%/%')
  or c_total_activos like ('%#%')
  or len(c_total_activos) = 1
  or c_total_activos      <= 0

  insert into #inf_tabla1
    select
      'Total Activos Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Total Activos Vacios => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  c_total_activos = ''
        or c_total_activos is null
           and c_total_activos <> 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (17) FORMATO 3  Total PAtrimonio'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.en_patrimonio_tec'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  -- en_patrimonio_tec > 1000000000
    en_patrimonio_tec like ('%º%')
  or en_patrimonio_tec like ('%!%')
  or en_patrimonio_tec like ('%"%')
  or en_patrimonio_tec like ('%*%')
  or en_patrimonio_tec like ('%&%')
  or en_patrimonio_tec like ('%|%')
  or en_patrimonio_tec like ('%$%')
  or en_patrimonio_tec like ('%(%')
  or en_patrimonio_tec like ('%;%')
  or en_patrimonio_tec like ('%)%')
  or en_patrimonio_tec like ('%:%')
  or en_patrimonio_tec like ('%[%')
  or en_patrimonio_tec like ('%]%')
  or en_patrimonio_tec like ('%{%')
  or en_patrimonio_tec like ('%}%')
  or en_patrimonio_tec like ('%~%')
  or en_patrimonio_tec like ('%+%')
  or en_patrimonio_tec like ('%¼%')
  or en_patrimonio_tec like ('%@%')
  or en_patrimonio_tec like ('%/%')
  or en_patrimonio_tec like ('%#%')
  or len(en_patrimonio_tec) = 1
  or en_patrimonio_tec      <= 0

  insert into #inf_tabla1
    select
      'Total Patrimonio Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Total Patrimonio Vacio => ' + convert(varchar(12), count(distinct en_ente
      )
      )
    from   #clientesCompanias
    where  en_patrimonio_tec is null
        or en_patrimonio_tec = ''
           and en_patrimonio_tec <> 0

  insert into #inf_tabla1
    select
      '---------------  CAMPO (18) FORMATO 3  Total Pasivo'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.c_total_pasivos'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  --c_total_pasivos > 1000000000
    c_total_pasivos like ('%º%')
  or c_total_pasivos like ('%!%')
  or c_total_pasivos like ('%"%')
  or c_total_pasivos like ('%*%')
  or c_total_pasivos like ('%&%')
  or c_total_pasivos like ('%|%')
  or c_total_pasivos like ('%$%')
  or c_total_pasivos like ('%(%')
  or c_total_pasivos like ('%;%')
  or c_total_pasivos like ('%)%')
  or c_total_pasivos like ('%:%')
  or c_total_pasivos like ('%[%')
  or c_total_pasivos like ('%]%')
  or c_total_pasivos like ('%{%')
  or c_total_pasivos like ('%}%')
  or c_total_pasivos like ('%~%')
  or c_total_pasivos like ('%+%')
  or c_total_pasivos like ('%¼%')
  or c_total_pasivos like ('%@%')
  or c_total_pasivos like ('%/%')
  or c_total_pasivos like ('%#%')
  or c_total_pasivos < 0

  insert into #inf_tabla1
    select
      'Total Pasivo Inconsistencias => ' + convert(varchar(12), @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Total Pasivo Vacios => ' + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  c_total_pasivos is null
        or c_total_pasivos = ''
           and c_total_pasivos <> 0

  insert into #inf_tabla1
    select
'---------------  CAMPO (19) FORMATO 3  Total Operaciones en Moneda Extranjera---------------------------------'

  insert into #inf_tabla1
    select
      ' TABLA : cl_relacion_inter.ri_num_producto '

  insert into #inf_tabla1
    select
      '----- Validacion de numero de producto'

  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias,
         cobis..cl_relacion_inter
  where  en_ente = ri_ente
     and (ri_num_producto like ('%º%')
           or ri_num_producto like ('%!%')
           or ri_num_producto like ('%"%')
           or ri_num_producto like ('%*%')
           or ri_num_producto like ('%&%')
           or ri_num_producto like ('%|%')
           or ri_num_producto like ('%$%')
           or ri_num_producto like ('%(%')
           or ri_num_producto like ('%;%')
           or ri_num_producto like ('%)%')
           or ri_num_producto like ('%:%')
           or ri_num_producto like ('%[%')
           or ri_num_producto like ('%]%')
           or ri_num_producto like ('%{%')
           or ri_num_producto like ('%}%')
           or ri_num_producto like ('%~%')
           or ri_num_producto like ('%+%')
           or ri_num_producto like ('%¼%')
           or ri_num_producto like ('%@%')
           or ri_num_producto like ('%/%')
           or ri_num_producto like ('%#%'))

  insert into #inf_tabla1
    select
      'Operacion Moneda Extranjera Inconsistencias => ' + convert(varchar(12),
      @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Operacion Moneda Extranjera Vacio => '
      + convert(varchar(12), count(distinct en_ente))
    from   cobis..cl_relacion_inter,
           #clientesCompanias
    where  en_ente                       = ri_ente
       and (rtrim(ltrim(ri_num_producto)) = ''
             or ri_num_producto is null)

  insert into #inf_tabla1
    select
      'Operacion Moneda Extranjera en 0 => '
      + convert(varchar(12), count(distinct en_ente))
    from   cobis..cl_relacion_inter,
           #clientesCompanias
    where  en_ente                       = ri_ente
       and rtrim(ltrim(ri_num_producto)) = '0'

  insert into #inf_tabla1
    select
      '---------  CAMPO (20) FORMATO 3  FEcha Diligenciamiento'

  insert into #inf_tabla1
    select
      'Campo: cl_ente.en_fecha_crea'

  insert into #inf_tabla1
    select
  '----- Validacion de fecha de creacion mayor a la fecha actual o que sea nula'
  select
    @w_variables = @w_variables + 1

  select
    @w_aux = count(distinct en_ente)
  from   #clientesCompanias
  where  datepart(yyyy,
                  en_fecha_crea) <= 1990
      or datepart(yyyy,
                  en_fecha_crea) > 2013

  insert into #inf_tabla1
    select
      'Fecha de Diligenciamiento Inconsistencias => ' + convert(varchar(12),
      @w_aux)
  select
    @w_inconsistencias = @w_inconsistencias + @w_aux

  insert into #inf_tabla1
    select
      'Fecha de Diligenciamiento Vacias => '
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_fecha_crea is null
        or en_fecha_crea = ''

  insert into #inf_tabla1
    select
      'Fecha de Diligenciamiento en 0 => ' + convert(varchar(12), count(distinct
      en_ente))
    from   #clientesCompanias
    where  en_fecha_crea = 0

  select
    @w_total_reg = count(1)
  from   #clientesCompanias

  insert into #inf_tabla1
    select
      char(10) + 'EL NUMERO DE CLIENTES ACTIVOS TIPO COMPAnIA ES => '
      + cast(@w_total_reg as varchar)

  select
    @w_total_reg = @w_total_reg * @w_variables

  insert into #inf_tabla1
    select
      char(10) + 'EL NUMERO TOTAL DE REGISTROS PARA COMPAnIAS ES => '
      + cast(@w_total_reg as varchar) + char(10)

  insert into #inf_tabla1
    select
      'CLIENTES DESACTIALIZADOS TIPO COMPAnIA => '
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_fecha_mod <= dateadd(yyyy,
                                   -1,
                                   @w_fecha_rep)

  insert into #inf_tabla1
    select
      char(10) + 'EL NUMERO TOTAL DE INCONSISTENCIAS ES => '
      + cast(@w_inconsistencias as varchar)

  insert into #inf_tabla1
    select
'CLIENTES ACTIVOS DESACTIALIZADOS TIPO COMPAnIA POR DEUDOR PPAL, CODEUDOR - ACTIVAS => '
+ convert(varchar(12), count(distinct en_ente))
from   #clientesCompanias
where  en_fecha_mod <= dateadd(yyyy,
                               -1,
                               @w_fecha_rep)
   and ROL in ('DEUDOR PPAL - ACTIVAS', 'CODEUDOR - ACTIVAS')

  insert into #inf_tabla1
    select
      'CLIENTES PASIVOS DESACTIALIZADOS TIPO COMPAnIA POR TITULAR - PASIVAS => '
      + convert(varchar(12), count(distinct en_ente))
    from   #clientesCompanias
    where  en_fecha_mod <= dateadd(yyyy,
                                   -1,
                                   @w_fecha_rep)
       and ROL in ('TITULAR - PASIVAS')

  /* DISCRIMINACION POR PRODUCTO */
  insert into #inf_tabla1
    select
'Discriminacion del numero total de clientes para el producto tipo persona (7,203) => '
+ convert(varchar(12), count(distinct en_ente))
from   cob_conta_super..sb_cliente_dato_sfc,
       cobis..cl_ente
where  producto in (7, 203)
   and en_ente    = cliente_u
   and en_subtipo = 'P'

  insert into #inf_tabla1
    select
'Discriminacion del numero total de clientes para el producto tipo persona (14,4) => '
+ convert(varchar(12), count(distinct en_ente))
from   cob_conta_super..sb_cliente_dato_sfc,
       cobis..cl_ente
where  producto in (14, 4)
   and en_ente    = cliente_u
   and en_subtipo = 'P'

  insert into #inf_tabla1
    select
'Discriminacion del numero total de clientes para el producto tipo compania (7,203) => '
+ convert(varchar(12), count(distinct en_ente))
from   cob_conta_super..sb_cliente_dato_sfc,
       cobis..cl_ente
where  producto in (7, 203)
   and en_ente    = cliente_u
   and en_subtipo = 'C'

  insert into #inf_tabla1
    select
'Discriminacion del numero total de clientes para el producto tipo compania (14,4) => '
+ convert(varchar(12), count(distinct en_ente))
from   cob_conta_super..sb_cliente_dato_sfc,
       cobis..cl_ente
where  producto in (14, 4)
   and en_ente    = cliente_u
   and en_subtipo = 'C'

  select
    *
  into   cl_dato_sarlaft2
  from   #inf_tabla1

  /**** ENVIO INFORMACION AL REPOSITORIO ****/

  insert into cob_conta_super..sb_dato_ente_sfc
    select distinct
      cliente_u,en_nombre,en_subtipo,en_ced_ruc,en_fecha_crea,
      en_fecha_mod,en_direccion,en_balance,en_actividad,en_tipo_ced,
      en_nit,p_p_apellido,p_s_apellido,p_fecha_nac,p_ciudad_nac,
      p_profesion,p_nivel_ing,p_nivel_egr,p_tipo_persona,c_tipo_compania,
      en_nomlar,c_total_activos,c_ciudad,en_patrimonio_tec,en_fecha_patri_bruto,
      en_concordato,c_total_pasivos,en_otringr,(select
         ci_descripcion
       from   cobis..cl_ciudad
       where  ci_ciudad = p_ciudad_nac),(select
         valor
       from   cobis..cl_catalogo
       where  tabla  = 548
          and codigo = en_actividad),
      @w_fecha
    from   cobis..cl_ente,
           cob_conta_super..sb_cliente_dato_sfc
    where  en_ente = cliente_u

  insert into cob_conta_super..sb_dato_direccion_sfc
    select
      di_ente,di_direccion,di_descripcion,di_ciudad,di_tipo,
      di_fecha_registro,di_fecha_modificacion,di_principal,di_rural_urb,
      di_provincia
      ,
      di_parroquia,@w_fecha
    from   cobis..cl_direccion,
           cob_conta_super..sb_cliente_dato_sfc
    where  di_ente = cliente_u

  insert into cob_conta_super..sb_dato_telefono_sfc
    select distinct
      cliente_u,te_direccion,te_secuencial,te_valor,te_tipo_telefono,
      te_prefijo,te_fecha_registro,te_fecha_mod,@w_fecha
    from   cobis..cl_telefono,
           cob_conta_super..sb_cliente_dato_sfc
    where  te_ente = cliente_u

  insert into cob_conta_super..sb_dato_socios_sfc
    select distinct
      cliente_u,in_ente_d,in_relacion,en_ced_ruc,(select top 1
         (te_prefijo + te_valor)
       from   cobis..cl_telefono
       where  te_ente = en_ente),
      in_fecha,@w_fecha
    from   cobis..cl_instancia,
           cob_conta_super..sb_cliente_dato_sfc,
           cobis..cl_ente
    where  in_ente_i = cliente_u
       and in_ente_i = en_ente
       and cliente_u = en_ente

  insert into cob_conta_super..sb_dato_relacion_inter_sfc
    select distinct
      cliente_u,ri_relacion,ri_institucion,ri_tipo_relacion,ri_num_producto,
      ri_moneda,ri_ciudad,ri_fecha_desde,ri_pais,ri_fecha_registro,
      ri_fecha_modificacion,ri_vigencia,ri_verificado,ri_funcionario,ri_monto,
      @w_fecha
    from   cobis..cl_relacion_inter,
           cob_conta_super..sb_cliente_dato_sfc
    where  ri_ente = cliente_u

  insert into cob_conta_super..sb_dato_otros_ingresos_sfc
    select distinct
      cliente_u,oi_tipo,oi_valor,oi_descripcion,oi_moneda,
      oi_usuario,oi_fecha_ingreso,oi_fecha_modifi,oi_estado,oi_cod_descripcion,
      @w_fecha
    from   cobis..cl_otros_ingresos,
           cob_conta_super..sb_cliente_dato_sfc
    where  oi_ente = cliente_u

  select
    @w_sp_name_batch = 'cobis..sp_calidata'

  /* Obtiene el path donde se va a generar el informe : VBatch\Clientes\Listados */
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    goto ERROR_INF
  end

  /* Obtiene el parametro de la ubicacion del kernel\bin en el servidor */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR AL OBTENER EL PARAMETRO GENERAL S_APP DE ADM'
    goto ERROR_INF
  end

  /* Obtiene los nombres de los informes */
  select
    @w_fecha_arch = convert(char(10), @w_fecha, 112)
  print 'Fecha Archivo ->' + convert(varchar(10), @w_fecha_arch)
  select
    @w_fecha_arch = substring(@w_fecha_arch, 7, 2) + substring(@w_fecha_arch, 5,
                    2
                    )
                    + substring(@w_fecha_arch, 1, 4)
  print @w_fecha_arch
  select
    @w_nombre_arch_txt = @w_path + 'Calidata' + @w_fecha_arch
  select
    @w_nombre_arch_err = @w_nombre_arch_txt + '.err'
  select
    @w_errores = @w_path + @w_nombre_arch_err
  select
    @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..cl_dato_sarlaft2 out '
  select
       @w_comando = @w_cmd + @w_nombre_arch_txt + ' -c -e' + @w_nombre_arch_err
                    +
                    ' -t"|" '
    +
                    '-config '
    + @w_s_app
                 + 's_app.ini'
  print @w_comando
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR GENERANDO ARCHIVO PLANO: '
    print @w_comando
    goto ERROR_INF
  end

  return 0

  ERROR_INF:

  exec cobis..sp_errorlog
    @i_fecha       = @w_fecha_rep,
    @i_error       = '28010',
    @i_usuario     = 'op-batch',
    @i_tran        = 1,
    @i_tran_name   = 'I',
    @i_descripcion = @w_msg,
    @i_rollback    = 'N'

  print @w_msg

  return @w_error

go

