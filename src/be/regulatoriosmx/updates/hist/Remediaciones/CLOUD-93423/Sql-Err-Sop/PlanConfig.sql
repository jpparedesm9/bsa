    -----------------
	---Indicaciones
	-----------------
	--1.- Ubicarse en la ruta: \cobishome\CTS_MF\infrastructure\
	--2.- Sacar respaldo del archivo cts-ccm-plan-config.xml
	--3.- Abrir el archivo: cts-ccm-plan-config.xml
	--4.- Buscar:
	<plugin name="assts.trnsc.voucherpaymentmail.services" path="../../ASSETS/transactions/assts.trnsc.voucherpaymentmail.services-1.0.0.jar"/>
	--5.- A continuación pegar lo siguiente:
	<plugin name="assts.trnsc.precancellationloanreference.services" path="../../ASSETS/transactions/assts.trnsc.precancellationloanreference.services-1.0.0.jar"/>

	--6.- Buscar:
	<plugin name="assts.trnsc.voucherpaymentmail.customevents" path="../../ASSETS/transactions/assts.trnsc.voucherpaymentmail.customevents-1.0.0.jar"/>
	--7.- A continuación pegar lo siguiente:
	<plugin name="assts.trnsc.precancellationloanreference.customevents" path="../../ASSETS/transactions/assts.trnsc.precancellationloanreference.customevents-1.0.0.jar"/>
    
	