<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FRangoEdadClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    'UserControl overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FRangoEdadClass))
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.grdRangoEdades = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.frmEstado = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optBoton_0 = New System.Windows.Forms.RadioButton()
        Me._optBoton_1 = New System.Windows.Forms.RadioButton()
        Me.Label3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSBotones.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        CType(Me.grdRangoEdades, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.frmEstado, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmEstado.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(633, 25)
        Me.TSBotones.TabIndex = 35
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "30000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "1003")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBCrear
        '
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "30030")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "1004")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "30005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "1002")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "30006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "1005")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        Me.TSBEliminar.Visible = False
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "30003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "1006")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me.GroupBox2)
        Me.UltraGroupBox1.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(6, 28)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox1.Size = New System.Drawing.Size(620, 394)
        Me.UltraGroupBox1.TabIndex = 36
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox2.Controls.Add(Me.grdRangoEdades)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.Location = New System.Drawing.Point(6, 169)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(605, 217)
        Me.GroupBox2.TabIndex = 7
        Me.GroupBox2.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        'grdRangoEdades
        '
        Me.grdRangoEdades._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRangoEdades, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRangoEdades, False)
        Me.grdRangoEdades.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRangoEdades.Clip = ""
        Me.grdRangoEdades.Col = CType(1, Short)
        Me.grdRangoEdades.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRangoEdades.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRangoEdades.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRangoEdades, "Default")
        Me.grdRangoEdades.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRangoEdades, True)
        Me.grdRangoEdades.FixedCols = CType(1, Short)
        Me.grdRangoEdades.FixedRows = CType(1, Short)
        Me.grdRangoEdades.ForeColor = System.Drawing.Color.Black
        Me.grdRangoEdades.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRangoEdades.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRangoEdades.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRangoEdades.HighLight = True
        Me.grdRangoEdades.Location = New System.Drawing.Point(6, 19)
        Me.grdRangoEdades.Name = "grdRangoEdades"
        Me.grdRangoEdades.Picture = Nothing
        Me.grdRangoEdades.Row = CType(0, Short)
        Me.grdRangoEdades.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRangoEdades.SelectionMode = COBISCorp.Framework.UI.Components.COBISGrid.SelectionModeEnum.FullRowSelect
        Me.grdRangoEdades.Size = New System.Drawing.Size(593, 192)
        Me.grdRangoEdades.Sort = CType(2, Short)
        Me.grdRangoEdades.TabIndex = 8
        Me.grdRangoEdades.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRangoEdades, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me._txtCampo_4)
        Me.GroupBox1.Controls.Add(Me._txtCampo_3)
        Me.GroupBox1.Controls.Add(Me._txtCampo_2)
        Me.GroupBox1.Controls.Add(Me.Label4)
        Me.GroupBox1.Controls.Add(Me.Label2)
        Me.GroupBox1.Controls.Add(Me.frmEstado)
        Me.GroupBox1.Controls.Add(Me.Label3)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.GroupBox1.Controls.Add(Me._txtCampo_1)
        Me.GroupBox1.Controls.Add(Me.Label1)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Location = New System.Drawing.Point(6, 3)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(605, 160)
        Me.GroupBox1.TabIndex = 60
        Me.GroupBox1.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Location = New System.Drawing.Point(106, 96)
        Me._txtCampo_4.MaxLength = 60
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(487, 20)
        Me._txtCampo_4.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(106, 70)
        Me._txtCampo_3.MaxLength = 5
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(83, 20)
        Me._txtCampo_3.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(106, 43)
        Me._txtCampo_2.MaxLength = 5
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(83, 20)
        Me._txtCampo_2.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        'Label4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label4, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label4, False)
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.CausesValidation = False
        Me.COBISStyleProvider.SetControlStyle(Me.Label4, "Default")
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.ForeColor = System.Drawing.Color.Navy
        Me.Label4.Location = New System.Drawing.Point(12, 127)
        Me.Label4.Name = "Label4"
        Me.COBISResourceProvider.SetResourceID(Me.Label4, "1340")
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(65, 20)
        Me.Label4.TabIndex = 39
        Me.Label4.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label4, "")
        '
        'Label2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label2, False)
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label2, "Default")
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.ForeColor = System.Drawing.Color.Navy
        Me.Label2.Location = New System.Drawing.Point(12, 70)
        Me.Label2.Name = "Label2"
        Me.COBISResourceProvider.SetResourceID(Me.Label2, "502083")
        Me.Label2.Size = New System.Drawing.Size(79, 20)
        Me.Label2.TabIndex = 37
        Me.Label2.Text = "*Edad Hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label2, "")
        '
        'frmEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmEstado, False)
        Me.frmEstado.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmEstado.Controls.Add(Me._optBoton_0)
        Me.frmEstado.Controls.Add(Me._optBoton_1)
        Me.COBISStyleProvider.SetControlStyle(Me.frmEstado, "Default")
        Me.frmEstado.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmEstado.ForeColor = System.Drawing.Color.Navy
        Me.frmEstado.Location = New System.Drawing.Point(106, 122)
        Me.frmEstado.Name = "frmEstado"
        Me.frmEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmEstado.Size = New System.Drawing.Size(194, 29)
        Me.frmEstado.TabIndex = 4
        Me.frmEstado.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmEstado, "")
        '
        '_optBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optBoton_0, False)
        Me._optBoton_0.BackColor = System.Drawing.Color.Transparent
        Me._optBoton_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optBoton_0, "Default")
        Me._optBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optBoton_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optBoton_0.ForeColor = System.Drawing.Color.Navy
        Me._optBoton_0.Location = New System.Drawing.Point(8, 3)
        Me._optBoton_0.Name = "_optBoton_0"
        Me.COBISResourceProvider.SetResourceID(Me._optBoton_0, "1832")
        Me._optBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optBoton_0.Size = New System.Drawing.Size(73, 20)
        Me._optBoton_0.TabIndex = 5
        Me._optBoton_0.TabStop = True
        Me._optBoton_0.Text = "*Vigente"
        Me._optBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optBoton_0, "")
        '
        '_optBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optBoton_1, False)
        Me._optBoton_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optBoton_1, "Default")
        Me._optBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optBoton_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optBoton_1.ForeColor = System.Drawing.Color.Navy
        Me._optBoton_1.Location = New System.Drawing.Point(93, 3)
        Me._optBoton_1.Name = "_optBoton_1"
        Me.COBISResourceProvider.SetResourceID(Me._optBoton_1, "1504")
        Me._optBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optBoton_1.Size = New System.Drawing.Size(95, 20)
        Me._optBoton_1.TabIndex = 6
        Me._optBoton_1.TabStop = True
        Me._optBoton_1.Text = "*No Vigente"
        Me._optBoton_1.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optBoton_1, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.ForeColor = System.Drawing.Color.Navy
        Me.Label3.Location = New System.Drawing.Point(12, 97)
        Me.Label3.Name = "Label3"
        Me.COBISResourceProvider.SetResourceID(Me.Label3, "502084")
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(76, 20)
        Me.Label3.TabIndex = 38
        Me.Label3.Text = "*Descripcion:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(12, 17)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1094")
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(50, 20)
        Me._lblEtiqueta_2.TabIndex = 34
        Me._lblEtiqueta_2.Text = "*Codigo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(106, 17)
        Me._txtCampo_1.MaxLength = 5
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(83, 20)
        Me._txtCampo_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(12, 43)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "502082")
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(79, 20)
        Me.Label1.TabIndex = 36
        Me.Label1.Text = "*Edad Desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'FRangoEdadClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.Controls.Add(Me.UltraGroupBox1)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FRangoEdadClass"
        Me.Size = New System.Drawing.Size(633, 425)
        Me.Text = "*Mantenimiento Rango Edades"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.GroupBox2.ResumeLayout(False)
        CType(Me.grdRangoEdades, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.frmEstado, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmEstado.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Private WithEvents commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents Label4 As System.Windows.Forms.Label
    Private WithEvents Label2 As System.Windows.Forms.Label
    Public WithEvents frmEstado As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optBoton_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optBoton_1 As System.Windows.Forms.RadioButton
    Private WithEvents Label3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents Label1 As System.Windows.Forms.Label
    Public WithEvents grdRangoEdades As COBISCorp.Framework.UI.Components.COBISGrid
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer

    Public Sub New()
        MyBase.New()

        InitializeComponent()
        InitializetxtCampo()
       


    End Sub
    Public txtCampo(4) As System.Windows.Forms.TextBox
    Sub InitializetxtCampo()
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(4) = _txtCampo_4


    End Sub

End Class
