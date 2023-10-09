Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FConcTrn() As FConcTrnClass
		Get
			Return FConcTrnClass.GetInstance(Of FConcTrnClass)()
		End Get
	End Property
	Public ReadOnly Property FParamConta() As FParamContaClass
		Get
			Return FParamContaClass.GetInstance(Of FParamContaClass)()
		End Get
	End Property
	Public ReadOnly Property FPerfil() As FPerfilClass
		Get
			Return FPerfilClass.GetInstance(Of FPerfilClass)()
		End Get
	End Property
	Public ReadOnly Property FTran493() As FTran493Class
		Get
			Return FTran493Class.GetInstance(Of FTran493Class)()
		End Get
	End Property
End Module
