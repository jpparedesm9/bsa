Imports COBISCorp.tCOBIS.PER.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FCapProFinal() As FCapProFinalClass
		Get
			Return FCapProFinalClass.GetInstance(Of FCapProFinalClass)()
		End Get
	End Property
	Public ReadOnly Property FCatProFinal() As FCatProFinalClass
		Get
			Return FCatProFinalClass.GetInstance(Of FCatProFinalClass)()
		End Get
	End Property
	Public ReadOnly Property FCicProFinal() As FCicProFinalClass
		Get
			Return FCicProFinalClass.GetInstance(Of FCicProFinalClass)()
		End Get
	End Property
	Public ReadOnly Property FMantTranAutorizada() As FMantTranAutorizadaClass
		Get
			Return FMantTranAutorizadaClass.GetInstance(Of FMantTranAutorizadaClass)()
		End Get
	End Property
	Public ReadOnly Property FParExt() As FParExtClass
		Get
			Return FParExtClass.GetInstance(Of FParExtClass)()
		End Get
	End Property
    Public ReadOnly Property FTrproban() As FTrprobanClass
        Get
            Return FTrprobanClass.GetInstance(Of FTrprobanClass)()
        End Get
    End Property
	Public ReadOnly Property FProCont() As FProContClass
		Get
			Return FProContClass.GetInstance(Of FProContClass)()
		End Get
	End Property
	Public ReadOnly Property FProFin() As FProFinClass
		Get
			Return FProFinClass.GetInstance(Of FProFinClass)()
		End Get
	End Property
	Public ReadOnly Property FTopesOfi() As FTopesOfiClass
		Get
			Return FTopesOfiClass.GetInstance(Of FTopesOfiClass)()
		End Get
    End Property


    Public ReadOnly Property FCaracteristicas() As FCaracteristicasClass
        Get
            Return FCaracteristicasClass.GetInstance(Of FCaracteristicasClass)()
        End Get
    End Property

    Public ReadOnly Property FRanEdad() As FRangoEdadClass
        Get
            Return FRangoEdadClass.GetInstance(Of FRangoEdadClass)()
        End Get
    End Property

  
End Module
