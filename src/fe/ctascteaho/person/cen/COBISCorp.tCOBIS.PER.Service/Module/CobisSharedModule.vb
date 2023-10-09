Imports COBISCorp.tCOBIS.PER.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FCreaBas() As FCreaBasClass
		Get
			Return FCreaBasClass.GetInstance(Of FCreaBasClass)()
		End Get
	End Property
	Public ReadOnly Property FAyudaProdFinal() As FAyudaProdFinalClass
		Get
			Return FAyudaProdFinalClass.GetInstance(Of FAyudaProdFinalClass)()
		End Get
	End Property
	Public ReadOnly Property FParCom() As FParComClass
		Get
			Return FParComClass.GetInstance(Of FParComClass)()
		End Get
	End Property
	Public ReadOnly Property FRubros() As FRubrosClass
		Get
			Return FRubrosClass.GetInstance(Of FRubrosClass)()
		End Get
	End Property
	Public ReadOnly Property FCreaServ() As FCreaServClass
		Get
			Return FCreaServClass.GetInstance(Of FCreaServClass)()
		End Get
	End Property
	Public ReadOnly Property Fsrvcon() As FsrvconClass
		Get
			Return FsrvconClass.GetInstance(Of FsrvconClass)()
		End Get
	End Property
	Public ReadOnly Property FVarServ() As FVarServClass
		Get
			Return FVarServClass.GetInstance(Of FVarServClass)()
		End Get
	End Property
End Module
