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
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Panel1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.lstCatalogo = New System.Windows.Forms.ListBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.listBoxHelper1 = New Artinsoft.VB6.Gui.ListBoxHelper(Me.components)
        Me.ToolStrip1.SuspendLayout()
        CType(Me.Panel1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
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
        Me.cmdSiguientes.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSiguientes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSiguientes.Location = New System.Drawing.Point(38, 63)
        Me.cmdSiguientes.Name = "cmdSiguientes"
        Me.cmdSiguientes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSiguientes.Size = New System.Drawing.Size(142, 23)
        Me.cmdSiguientes.TabIndex = 1
        Me.cmdSiguientes.Text = "&Siguientes"
        Me.cmdSiguientes.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSiguientes.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSiguientes, "")
        '
        'ToolStrip1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ToolStrip1, False)
        Me.COBISViewResizer.SetAutoResize(Me.ToolStrip1, False)
        Me.COBISStyleProvider.SetControlStyle(Me.ToolStrip1, "Default")
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSiguientes, Me.TSBEscoger, Me.TSBSalir})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(393, 25)
        Me.ToolStrip1.TabIndex = 2
        Me.ToolStrip1.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ToolStrip1, "")
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "30001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "1008")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Tag = "1"
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Black
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "30002")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "1842")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Text = "*Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*Salir"
        '
        'Panel1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Panel1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Panel1, False)
        Me.Panel1.BackColorInternal = System.Drawing.Color.White
        Me.Panel1.Controls.Add(Me.lstCatalogo)
        Me.COBISStyleProvider.SetControlStyle(Me.Panel1, "Default")
        Me.Panel1.Location = New System.Drawing.Point(10, 36)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(370, 199)
        Me.Panel1.TabIndex = 3
        Me.Panel1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Panel1, "")
        '
        'lstCatalogo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lstCatalogo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lstCatalogo, False)
        Me.lstCatalogo.BackColor = System.Drawing.Color.Silver
        Me.lstCatalogo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.lstCatalogo, "Default")
        Me.lstCatalogo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lstCatalogo.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lstCatalogo.ForeColor = System.Drawing.Color.Black
        Me.lstCatalogo.ItemHeight = 11
        Me.lstCatalogo.Location = New System.Drawing.Point(10, 10)
        Me.lstCatalogo.Name = "lstCatalogo"
        Me.lstCatalogo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.listBoxHelper1.SetSelectionMode(Me.lstCatalogo, System.Windows.Forms.SelectionMode.One)
        Me.lstCatalogo.Size = New System.Drawing.Size(351, 178)
        Me.lstCatalogo.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lstCatalogo, "")
        '
        'FCatalogoClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.ToolStrip1)
        Me.Controls.Add(Me.Panel1)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(285, 90)
        Me.Name = "FCatalogoClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(393, 249)
        Me.Text = "Registros Seleccionados"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        CType(Me.Panel1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents ToolStrip1 As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents Panel1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents lstCatalogo As System.Windows.Forms.ListBox
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


