Imports COBISCorp.tCOBIS.REC.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FCatalogoClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
		Dispose(True)
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> _
	 Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not (components Is Nothing) Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
	Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
	Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents cmdSiguientes As System.Windows.Forms.Button
	Public WithEvents lstCatalogo As System.Windows.Forms.ListBox
	Private listBoxHelper1 As Artinsoft.VB6.Gui.ListBoxHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FCatalogoClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.cmdSiguientes = New System.Windows.Forms.Button()
        Me.lstCatalogo = New System.Windows.Forms.ListBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.listBoxHelper1 = New Artinsoft.VB6.Gui.ListBoxHelper(Me.components)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        '
        'cmdSiguientes
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSiguientes, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSiguientes, False)
        Me.cmdSiguientes.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSiguientes, "Default")
        Me.cmdSiguientes.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSiguientes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSiguientes.Location = New System.Drawing.Point(-410, 74)
        Me.cmdSiguientes.Name = "cmdSiguientes"
        Me.cmdSiguientes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSiguientes.Size = New System.Drawing.Size(102, 41)
        Me.cmdSiguientes.TabIndex = 1
        Me.cmdSiguientes.Text = "&Siguientes"
        Me.cmdSiguientes.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSiguientes.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSiguientes, "")
        '
        'lstCatalogo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lstCatalogo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lstCatalogo, False)
        Me.lstCatalogo.BackColor = System.Drawing.Color.White
        Me.lstCatalogo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.lstCatalogo, "Default")
        Me.lstCatalogo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lstCatalogo.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lstCatalogo.ForeColor = System.Drawing.Color.Black
        Me.lstCatalogo.ItemHeight = 11
        Me.lstCatalogo.Location = New System.Drawing.Point(4, 4)
        Me.lstCatalogo.Name = "lstCatalogo"
        Me.lstCatalogo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.listBoxHelper1.SetSelectionMode(Me.lstCatalogo, System.Windows.Forms.SelectionMode.One)
        Me.lstCatalogo.Size = New System.Drawing.Size(351, 189)
        Me.lstCatalogo.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lstCatalogo, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.lstCatalogo)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(360, 197)
        Me.PFormas.TabIndex = 2
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSiguiente})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(380, 25)
        Me.TSBotones.TabIndex = 3
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2040")
        Me.TSBSiguiente.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguiente.Text = "*&Siguientes"
        '
        'FCatalogoClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(254, 110)
        Me.Name = "FCatalogoClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(380, 245)
        Me.Text = "Registros Seleccionados"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    ' Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
#End Region 
End Class


