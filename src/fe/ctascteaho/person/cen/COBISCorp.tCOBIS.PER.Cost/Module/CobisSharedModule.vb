Imports COBISCorp.tCOBIS.PER.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FConCostos() As FConCostosClass
		Get
			Return FConCostosClass.GetInstance(Of FConCostosClass)()
		End Get
	End Property
	Public ReadOnly Property FConsulMas() As FConsulMasClass
		Get
			Return FConsulMasClass.GetInstance(Of FConsulMasClass)()
		End Get
	End Property
	Public ReadOnly Property FConsulMas2() As FConsulMas2Class
		Get
			Return FConsulMas2Class.GetInstance(Of FConsulMas2Class)()
		End Get
	End Property
	Public ReadOnly Property FConsultaPer() As FConsultaPerClass
		Get
			Return FConsultaPerClass.GetInstance(Of FConsultaPerClass)()
		End Get
	End Property
	Public ReadOnly Property FConsVal() As FConsValClass
		Get
			Return FConsValClass.GetInstance(Of FConsValClass)()
		End Get
	End Property
	Public ReadOnly Property FContratacion() As FContratacionClass
		Get
			Return FContratacionClass.GetInstance(Of FContratacionClass)()
		End Get
	End Property
	Public ReadOnly Property FconVarCosto() As FconVarCostoClass
		Get
			Return FconVarCostoClass.GetInstance(Of FconVarCostoClass)()
		End Get
	End Property
	Public ReadOnly Property FCosEsp() As FCosEspClass
		Get
			Return FCosEspClass.GetInstance(Of FCosEspClass)()
		End Get
	End Property
	Public ReadOnly Property FPersoCuenta() As FPersoCuentaClass
		Get
			Return FPersoCuentaClass.GetInstance(Of FPersoCuentaClass)()
		End Get
	End Property
	Public ReadOnly Property FAyudaSubserv() As FAyudaSubservClass
		Get
			Return FAyudaSubservClass.GetInstance(Of FAyudaSubservClass)()
		End Get
	End Property
	Public ReadOnly Property FAyudaSubserv2() As FAyudaSubserv2Class
		Get
			Return FAyudaSubserv2Class.GetInstance(Of FAyudaSubserv2Class)()
		End Get
	End Property
	Public ReadOnly Property FMantenimiento() As FMantenimientoClass
		Get
			Return FMantenimientoClass.GetInstance(Of FMantenimientoClass)()
		End Get
	End Property
	Public ReadOnly Property FManteEspecial() As FManteEspecialClass
		Get
			Return FManteEspecialClass.GetInstance(Of FManteEspecialClass)()
		End Get
	End Property
	Public ReadOnly Property FMantenLinea() As FMantenLineaClass
		Get
			Return FMantenLineaClass.GetInstance(Of FMantenLineaClass)()
		End Get
	End Property
	Public ReadOnly Property FMantenLinea2() As FMantenLinea2Class
		Get
			Return FMantenLinea2Class.GetInstance(Of FMantenLinea2Class)()
		End Get
	End Property
	Public ReadOnly Property FPersoEspecial() As FPersoEspecialClass
		Get
			Return FPersoEspecialClass.GetInstance(Of FPersoEspecialClass)()
		End Get
	End Property
	Public ReadOnly Property FRegistros() As FRegistrosClass
		Get
			Return FRegistrosClass.GetInstance(Of FRegistrosClass)()
		End Get
    End Property
    Public ReadOnly Property FTrprobaen() As FTrprobaenClass
        Get
            Return FTrprobaenClass.GetInstance(Of FTrprobaenClass)()
        End Get
    End Property
End Module
