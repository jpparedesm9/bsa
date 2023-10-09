<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FAyuda2Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializelblEtiqueta()
		InitializecmdSeleccion()
		InitializeLine1()
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
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdSeleccion_3 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_2 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_1 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_0 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
	Public cmdSeleccion(3) As System.Windows.Forms.Button
	Public lblEtiqueta(0) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAyuda2Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdSeleccion_3 = New System.Windows.Forms.Button()
        Me._cmdSeleccion_2 = New System.Windows.Forms.Button()
        Me._cmdSeleccion_1 = New System.Windows.Forms.Button()
        Me._cmdSeleccion_0 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.PFORMAS = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSigg = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFORMAS, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFORMAS.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
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
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(125, 10)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(190, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdSeleccion_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_3.Location = New System.Drawing.Point(-610, 204)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_3, System.Drawing.Color.Silver)
        Me._cmdSeleccion_3.Name = "_cmdSeleccion_3"
        Me._cmdSeleccion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_3.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_3, 1)
        Me._cmdSeleccion_3.TabIndex = 4
        Me._cmdSeleccion_3.Text = "*&Salir"
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
        Me._cmdSeleccion_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_2.Location = New System.Drawing.Point(-610, 140)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_2, System.Drawing.Color.Silver)
        Me._cmdSeleccion_2.Name = "_cmdSeleccion_2"
        Me._cmdSeleccion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_2.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_2, 1)
        Me._cmdSeleccion_2.TabIndex = 3
        Me._cmdSeleccion_2.Text = "*&Escoger"
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
        Me._cmdSeleccion_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_1.Location = New System.Drawing.Point(-610, 87)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_1, System.Drawing.Color.Silver)
        Me._cmdSeleccion_1.Name = "_cmdSeleccion_1"
        Me._cmdSeleccion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_1.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_1, 1)
        Me._cmdSeleccion_1.TabIndex = 2
        Me._cmdSeleccion_1.Text = "*Sig&tes."
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
        Me._cmdSeleccion_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_0.Location = New System.Drawing.Point(-610, 23)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_0, System.Drawing.Color.Silver)
        Me._cmdSeleccion_0.Name = "_cmdSeleccion_0"
        Me._cmdSeleccion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_0.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_0, 1)
        Me._cmdSeleccion_0.TabIndex = 1
        Me._cmdSeleccion_0.Text = "*&Buscar"
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
        Me.grdRegistros.Size = New System.Drawing.Size(370, 229)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 5
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500120")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(101, 20)
        Me._lblEtiqueta_0.TabIndex = 6
        Me._lblEtiqueta_0.Text = "*Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'PFORMAS
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFORMAS, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFORMAS, False)
        Me.PFORMAS.BackColorInternal = System.Drawing.Color.White
        Me.PFORMAS.Controls.Add(Me.GroupBox1)
        Me.PFORMAS.Controls.Add(Me.mskCuenta)
        Me.PFORMAS.Controls.Add(Me._lblEtiqueta_0)
        Me.COBISStyleProvider.SetControlStyle(Me.PFORMAS, "Default")
        Me.PFORMAS.Location = New System.Drawing.Point(10, 36)
        Me.PFORMAS.Name = "PFORMAS"
        Me.PFORMAS.Size = New System.Drawing.Size(408, 282)
        Me.PFORMAS.TabIndex = 7
        Me.PFORMAS.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFORMAS, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(14, 33)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(376, 232)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSigg, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(426, 25)
        Me.TSBBotones.TabIndex = 8
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
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
        'TSBSigg
        '
        Me.TSBSigg.ForeColor = System.Drawing.Color.Navy
        Me.TSBSigg.Image = CType(resources.GetObject("TSBSigg.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSigg, "2020")
        Me.TSBSigg.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSigg.Name = "TSBSigg"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSigg, "500119")
        Me.TSBSigg.Size = New System.Drawing.Size(66, 22)
        Me.TSBSigg.Text = "*Sig&tes."
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
        'FAyuda2Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me.PFORMAS)
        Me.Controls.Add(Me._cmdSeleccion_3)
        Me.Controls.Add(Me._cmdSeleccion_2)
        Me.Controls.Add(Me._cmdSeleccion_1)
        Me.Controls.Add(Me._cmdSeleccion_0)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(198, 118)
        Me.Name = "FAyuda2Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(426, 325)
        Me.Tag = "3872"
        Me.Text = "*Lista de Cuentas de Movimiento"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFORMAS, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFORMAS.ResumeLayout(False)
        Me.PFORMAS.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdSeleccion()
        Me.cmdSeleccion(3) = _cmdSeleccion_3
        Me.cmdSeleccion(2) = _cmdSeleccion_2
        Me.cmdSeleccion(1) = _cmdSeleccion_1
        Me.cmdSeleccion(0) = _cmdSeleccion_0
    End Sub
    Sub InitializeLine1()
        ''Me.Line1(1) = _Line1_1
        ''Me.Line1(0) = _Line1_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFORMAS As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSigg As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


