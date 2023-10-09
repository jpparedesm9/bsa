Imports COBISCorp.tCOBIS.REC.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class grid_valoresClass
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
	Public WithEvents bb_cancelar As System.Windows.Forms.Button
	Public WithEvents bb_escoger As System.Windows.Forms.Button
	Public WithEvents bb_siguiente As System.Windows.Forms.Button
	Public WithEvents bb_buscar As System.Windows.Forms.Button
	Public WithEvents gr_SQL As COBISCorp.Framework.UI.Components.COBISGrid
	Public WithEvents dl_sp As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(grid_valoresClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.bb_cancelar = New System.Windows.Forms.Button()
        Me.bb_escoger = New System.Windows.Forms.Button()
        Me.bb_siguiente = New System.Windows.Forms.Button()
        Me.bb_buscar = New System.Windows.Forms.Button()
        Me.gr_SQL = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.dl_sp = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBCancelar = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.gr_SQL, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBotones.SuspendLayout()
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
        'bb_cancelar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.bb_cancelar, False)
        Me.COBISViewResizer.SetAutoResize(Me.bb_cancelar, False)
        Me.bb_cancelar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.bb_cancelar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.bb_cancelar, True)
        Me.bb_cancelar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.bb_cancelar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.bb_cancelar, Nothing)
        Me.bb_cancelar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.bb_cancelar.Location = New System.Drawing.Point(-287, 138)
        Me.commandButtonHelper1.SetMaskColor(Me.bb_cancelar, System.Drawing.Color.Silver)
        Me.bb_cancelar.Name = "bb_cancelar"
        Me.bb_cancelar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.bb_cancelar.Size = New System.Drawing.Size(60, 25)
        Me.commandButtonHelper1.SetStyle(Me.bb_cancelar, 1)
        Me.bb_cancelar.TabIndex = 4
        Me.bb_cancelar.Text = "*&Cancelar"
        Me.bb_cancelar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bb_cancelar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.bb_cancelar, "")
        '
        'bb_escoger
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.bb_escoger, False)
        Me.COBISViewResizer.SetAutoResize(Me.bb_escoger, False)
        Me.bb_escoger.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.bb_escoger, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.bb_escoger, True)
        Me.bb_escoger.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.bb_escoger, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.bb_escoger, Nothing)
        Me.bb_escoger.ForeColor = System.Drawing.SystemColors.ControlText
        Me.bb_escoger.Location = New System.Drawing.Point(-226, 138)
        Me.commandButtonHelper1.SetMaskColor(Me.bb_escoger, System.Drawing.Color.Silver)
        Me.bb_escoger.Name = "bb_escoger"
        Me.bb_escoger.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.bb_escoger.Size = New System.Drawing.Size(60, 25)
        Me.commandButtonHelper1.SetStyle(Me.bb_escoger, 1)
        Me.bb_escoger.TabIndex = 3
        Me.bb_escoger.Text = "*&Escoger"
        Me.bb_escoger.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bb_escoger.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.bb_escoger, "")
        '
        'bb_siguiente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.bb_siguiente, False)
        Me.COBISViewResizer.SetAutoResize(Me.bb_siguiente, False)
        Me.bb_siguiente.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.bb_siguiente, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.bb_siguiente, True)
        Me.bb_siguiente.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.bb_siguiente, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.bb_siguiente, Nothing)
        Me.bb_siguiente.ForeColor = System.Drawing.SystemColors.ControlText
        Me.bb_siguiente.Location = New System.Drawing.Point(-123, 138)
        Me.commandButtonHelper1.SetMaskColor(Me.bb_siguiente, System.Drawing.Color.Silver)
        Me.bb_siguiente.Name = "bb_siguiente"
        Me.bb_siguiente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.bb_siguiente.Size = New System.Drawing.Size(60, 25)
        Me.commandButtonHelper1.SetStyle(Me.bb_siguiente, 1)
        Me.bb_siguiente.TabIndex = 1
        Me.bb_siguiente.Text = "*Si&guiente"
        Me.bb_siguiente.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bb_siguiente.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.bb_siguiente, "")
        '
        'bb_buscar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.bb_buscar, False)
        Me.COBISViewResizer.SetAutoResize(Me.bb_buscar, False)
        Me.bb_buscar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.bb_buscar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.bb_buscar, True)
        Me.bb_buscar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.bb_buscar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.bb_buscar, Nothing)
        Me.bb_buscar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.bb_buscar.Location = New System.Drawing.Point(-61, 138)
        Me.commandButtonHelper1.SetMaskColor(Me.bb_buscar, System.Drawing.Color.Silver)
        Me.bb_buscar.Name = "bb_buscar"
        Me.bb_buscar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.bb_buscar.Size = New System.Drawing.Size(60, 25)
        Me.commandButtonHelper1.SetStyle(Me.bb_buscar, 1)
        Me.bb_buscar.TabIndex = 0
        Me.bb_buscar.Text = "*&Buscar"
        Me.bb_buscar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bb_buscar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.bb_buscar, "")
        '
        'gr_SQL
        '
        Me.gr_SQL._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.gr_SQL, False)
        Me.COBISViewResizer.SetAutoResize(Me.gr_SQL, False)
        Me.gr_SQL.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.gr_SQL.Clip = ""
        Me.gr_SQL.Col = CType(1, Short)
        Me.gr_SQL.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.gr_SQL.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.gr_SQL.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.gr_SQL, "Default")
        Me.gr_SQL.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.gr_SQL, True)
        Me.gr_SQL.FixedCols = CType(1, Short)
        Me.gr_SQL.FixedRows = CType(1, Short)
        Me.gr_SQL.ForeColor = System.Drawing.Color.Black
        Me.gr_SQL.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.gr_SQL.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.gr_SQL.GridColor = System.Drawing.SystemColors.ControlDark
        Me.gr_SQL.HighLight = True
        Me.gr_SQL.Location = New System.Drawing.Point(10, 10)
        Me.gr_SQL.Name = "gr_SQL"
        Me.gr_SQL.Picture = Nothing
        Me.gr_SQL.Row = CType(1, Short)
        Me.gr_SQL.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.gr_SQL.Size = New System.Drawing.Size(347, 136)
        Me.gr_SQL.Sort = CType(2, Short)
        Me.gr_SQL.TabIndex = 2
        Me.gr_SQL.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.gr_SQL, "")
        '
        'dl_sp
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.dl_sp, False)
        Me.COBISViewResizer.SetAutoResize(Me.dl_sp, False)
        Me.dl_sp.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.dl_sp.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.dl_sp, "Default")
        Me.dl_sp.Cursor = System.Windows.Forms.Cursors.Default
        Me.dl_sp.Location = New System.Drawing.Point(157, 150)
        Me.dl_sp.Name = "dl_sp"
        Me.dl_sp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.dl_sp.Size = New System.Drawing.Size(159, 18)
        Me.dl_sp.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me.dl_sp, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.gr_SQL)
        Me.PFormas.Controls.Add(Me.dl_sp)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(367, 176)
        Me.PFormas.TabIndex = 6
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBCancelar})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(391, 25)
        Me.TSBotones.TabIndex = 7
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "500327")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Text = "*Si&guiente"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Black
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "2021")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Text = "*&Escoger"
        '
        'TSBCancelar
        '
        Me.TSBCancelar.ForeColor = System.Drawing.Color.Black
        Me.TSBCancelar.Image = CType(resources.GetObject("TSBCancelar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCancelar, "2023")
        Me.TSBCancelar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCancelar.Name = "TSBCancelar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCancelar, "2012")
        Me.TSBCancelar.Size = New System.Drawing.Size(78, 22)
        Me.TSBCancelar.Text = "*&Cancelar"
        '
        'grid_valoresClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.bb_cancelar)
        Me.Controls.Add(Me.bb_escoger)
        Me.Controls.Add(Me.bb_siguiente)
        Me.Controls.Add(Me.bb_buscar)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(255, 95)
        Me.Name = "grid_valoresClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(391, 223)
        Me.Text = "Listado de Registros Seleccionados"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.gr_SQL, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCancelar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
#End Region 
End Class


