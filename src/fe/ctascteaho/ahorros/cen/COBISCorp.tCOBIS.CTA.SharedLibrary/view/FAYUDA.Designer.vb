<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FAyudaClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializecmdSeleccion()
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
    Private WithEvents _cmdSeleccion_3 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_2 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_1 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_0 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Public cmdSeleccion(3) As System.Windows.Forms.Button
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAyudaClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._cmdSeleccion_3 = New System.Windows.Forms.Button()
        Me._cmdSeleccion_2 = New System.Windows.Forms.Button()
        Me._cmdSeleccion_1 = New System.Windows.Forms.Button()
        Me._cmdSeleccion_0 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSbotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSigtes = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSbotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        '_cmdSeleccion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdSeleccion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdSeleccion_3, False)
        Me._cmdSeleccion_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdSeleccion_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_3, True)
        Me._cmdSeleccion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_3, Nothing)
        Me._cmdSeleccion_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_3.Image = CType(resources.GetObject("_cmdSeleccion_3.Image"), System.Drawing.Image)
        Me._cmdSeleccion_3.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdSeleccion_3.Location = New System.Drawing.Point(-529, 216)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_3, System.Drawing.Color.Silver)
        Me._cmdSeleccion_3.Name = "_cmdSeleccion_3"
        Me._cmdSeleccion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_3.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_3, 1)
        Me._cmdSeleccion_3.TabIndex = 4
        Me._cmdSeleccion_3.Text = "&Salir"
        Me._cmdSeleccion_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdSeleccion_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdSeleccion_3, "")
        '
        '_cmdSeleccion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdSeleccion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdSeleccion_2, False)
        Me._cmdSeleccion_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdSeleccion_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_2, True)
        Me._cmdSeleccion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_2, Nothing)
        Me._cmdSeleccion_2.Enabled = False
        Me._cmdSeleccion_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_2.Image = CType(resources.GetObject("_cmdSeleccion_2.Image"), System.Drawing.Image)
        Me._cmdSeleccion_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdSeleccion_2.Location = New System.Drawing.Point(-529, 157)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_2, System.Drawing.Color.Silver)
        Me._cmdSeleccion_2.Name = "_cmdSeleccion_2"
        Me._cmdSeleccion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_2.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_2, 1)
        Me._cmdSeleccion_2.TabIndex = 3
        Me._cmdSeleccion_2.Text = "&Escoger"
        Me._cmdSeleccion_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdSeleccion_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdSeleccion_2, "")
        '
        '_cmdSeleccion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdSeleccion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdSeleccion_1, False)
        Me._cmdSeleccion_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdSeleccion_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_1, True)
        Me._cmdSeleccion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_1, Nothing)
        Me._cmdSeleccion_1.Enabled = False
        Me._cmdSeleccion_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_1.Image = CType(resources.GetObject("_cmdSeleccion_1.Image"), System.Drawing.Image)
        Me._cmdSeleccion_1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdSeleccion_1.Location = New System.Drawing.Point(-529, 98)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_1, System.Drawing.Color.Silver)
        Me._cmdSeleccion_1.Name = "_cmdSeleccion_1"
        Me._cmdSeleccion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_1.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_1, 1)
        Me._cmdSeleccion_1.TabIndex = 2
        Me._cmdSeleccion_1.Text = "Sig&tes."
        Me._cmdSeleccion_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdSeleccion_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdSeleccion_1, "")
        '
        '_cmdSeleccion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdSeleccion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdSeleccion_0, False)
        Me._cmdSeleccion_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdSeleccion_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_0, True)
        Me._cmdSeleccion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_0, Nothing)
        Me._cmdSeleccion_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_0.Image = CType(resources.GetObject("_cmdSeleccion_0.Image"), System.Drawing.Image)
        Me._cmdSeleccion_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdSeleccion_0.Location = New System.Drawing.Point(-529, 39)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_0, System.Drawing.Color.Silver)
        Me._cmdSeleccion_0.Name = "_cmdSeleccion_0"
        Me._cmdSeleccion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_0.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_0, 1)
        Me._cmdSeleccion_0.TabIndex = 1
        Me._cmdSeleccion_0.Text = "&Buscar"
        Me._cmdSeleccion_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdSeleccion_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdSeleccion_0, "")
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CtlText = ""
        Me.grdRegistros.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(3, 0)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(365, 254)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 0
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(394, 283)
        Me.PFormas.TabIndex = 6
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(371, 257)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSbotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSbotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSbotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSbotones, "Default")
        Me.TSbotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSigtes, Me.TSBEscoger, Me.TSBSalir})
        Me.TSbotones.Location = New System.Drawing.Point(0, 0)
        Me.TSbotones.Name = "TSbotones"
        Me.TSbotones.Size = New System.Drawing.Size(416, 25)
        Me.TSbotones.TabIndex = 7
        Me.TSbotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSbotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSigtes
        '
        Me.TSBSigtes.ForeColor = System.Drawing.Color.Navy
        Me.TSBSigtes.Image = CType(resources.GetObject("TSBSigtes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSigtes, "2020")
        Me.TSBSigtes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSigtes.Name = "TSBSigtes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSigtes, "500119")
        Me.TSBSigtes.Size = New System.Drawing.Size(66, 22)
        Me.TSBSigtes.Text = "*Sig&tes."
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Navy
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "2021")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Text = "*&Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FAyudaClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSbotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdSeleccion_3)
        Me.Controls.Add(Me._cmdSeleccion_2)
        Me.Controls.Add(Me._cmdSeleccion_1)
        Me.Controls.Add(Me._cmdSeleccion_0)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(61, 113)
        Me.Name = "FAyudaClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(416, 329)
        Me.Text = "Lista de Registros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSbotones.ResumeLayout(False)
        Me.TSbotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializecmdSeleccion()
        Me.cmdSeleccion(3) = _cmdSeleccion_3
        Me.cmdSeleccion(2) = _cmdSeleccion_2
        Me.cmdSeleccion(1) = _cmdSeleccion_1
        Me.cmdSeleccion(0) = _cmdSeleccion_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSbotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSigtes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


