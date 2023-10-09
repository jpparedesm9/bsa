<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTra2946Class
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTra2946Class))
        Dim CheckBoxCellType1 As FarPoint.Win.Spread.CellType.CheckBoxCellType = New FarPoint.Win.Spread.CellType.CheckBoxCellType()
        Me.TSButton = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.lblProductoCobis = New System.Windows.Forms.Label()
        Me.lblContrato = New System.Windows.Forms.Label()
        Me.lblPlantilla = New System.Windows.Forms.Label()
        Me.lblDescrip = New System.Windows.Forms.Label()
        Me.lblEstado = New System.Windows.Forms.Label()
        Me.lblProductoBancario = New System.Windows.Forms.Label()
        Me.lblTipoPersona = New System.Windows.Forms.Label()
        Me.lblTitularidad = New System.Windows.Forms.Label()
        Me.chkEspecial = New System.Windows.Forms.CheckBox()
        Me.lblEspecial = New System.Windows.Forms.Label()
        Me.PForma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdContratos = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.CobisSpread1_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me.lblDescripcion = New System.Windows.Forms.Label()
        Me.txtPlantilla = New System.Windows.Forms.TextBox()
        Me.txtTipoPersona = New System.Windows.Forms.TextBox()
        Me.txtTitularidad = New System.Windows.Forms.TextBox()
        Me.lblDescTitularidad = New System.Windows.Forms.Label()
        Me.lblDescTipoPersona = New System.Windows.Forms.Label()
        Me.PForma2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.cmbTipo = New System.Windows.Forms.ComboBox()
        Me.txtEstado = New System.Windows.Forms.TextBox()
        Me.lblDescripcionEstado = New System.Windows.Forms.Label()
        Me.cmbProductoBancario = New System.Windows.Forms.ComboBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSButton.SuspendLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PForma.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me.grdContratos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CobisSpread1_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PForma2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PForma2.SuspendLayout()
        Me.SuspendLayout()
        '
        'TSButton
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSButton, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSButton, False)
        Me.TSButton.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.COBISStyleProvider.SetControlStyle(Me.TSButton, "Default")
        Me.TSButton.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBTransmitir, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSButton.Location = New System.Drawing.Point(0, 0)
        Me.TSButton.Name = "TSButton"
        Me.TSButton.Size = New System.Drawing.Size(639, 25)
        Me.TSButton.TabIndex = 8
        Me.TSButton.TabStop = True
        Me.TSButton.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSButton, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "30000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "1003")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "30007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "1009")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*Transmitir"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "30005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "1002")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "30006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "1005")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*Eliminar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "30003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "1006")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*Limpiar"
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
        'lblProductoCobis
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblProductoCobis, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblProductoCobis, False)
        Me.lblProductoCobis.AutoSize = True
        Me.lblProductoCobis.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblProductoCobis, "Default")
        Me.lblProductoCobis.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblProductoCobis.ForeColor = System.Drawing.Color.Navy
        Me.lblProductoCobis.Location = New System.Drawing.Point(6, 6)
        Me.lblProductoCobis.Name = "lblProductoCobis"
        Me.COBISResourceProvider.SetResourceID(Me.lblProductoCobis, "500233")
        Me.lblProductoCobis.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblProductoCobis.Size = New System.Drawing.Size(92, 13)
        Me.lblProductoCobis.TabIndex = 0
        Me.lblProductoCobis.Text = "*Producto COBIS:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblProductoCobis, "")
        '
        'lblContrato
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblContrato, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblContrato, False)
        Me.lblContrato.AutoSize = True
        Me.lblContrato.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblContrato, "Default")
        Me.lblContrato.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblContrato.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblContrato.ForeColor = System.Drawing.Color.Navy
        Me.lblContrato.Location = New System.Drawing.Point(6, 55)
        Me.lblContrato.Name = "lblContrato"
        Me.COBISResourceProvider.SetResourceID(Me.lblContrato, "500468")
        Me.lblContrato.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblContrato.Size = New System.Drawing.Size(54, 13)
        Me.lblContrato.TabIndex = 5
        Me.lblContrato.Text = "*Contrato:"
        Me.lblContrato.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblContrato, "")
        '
        'lblPlantilla
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblPlantilla, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblPlantilla, False)
        Me.lblPlantilla.AutoSize = True
        Me.lblPlantilla.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblPlantilla, "Default")
        Me.lblPlantilla.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPlantilla.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPlantilla.ForeColor = System.Drawing.Color.Navy
        Me.lblPlantilla.Location = New System.Drawing.Point(6, 79)
        Me.lblPlantilla.Name = "lblPlantilla"
        Me.COBISResourceProvider.SetResourceID(Me.lblPlantilla, "500472")
        Me.lblPlantilla.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPlantilla.Size = New System.Drawing.Size(90, 13)
        Me.lblPlantilla.TabIndex = 6
        Me.lblPlantilla.Text = "*Nombre Plantilla:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblPlantilla, "")
        '
        'lblDescrip
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescrip, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescrip, False)
        Me.lblDescrip.AutoSize = True
        Me.lblDescrip.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescrip, "Default")
        Me.lblDescrip.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescrip.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDescrip.ForeColor = System.Drawing.Color.Navy
        Me.lblDescrip.Location = New System.Drawing.Point(6, 101)
        Me.lblDescrip.Name = "lblDescrip"
        Me.COBISResourceProvider.SetResourceID(Me.lblDescrip, "500113")
        Me.lblDescrip.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescrip.Size = New System.Drawing.Size(70, 13)
        Me.lblDescrip.TabIndex = 8
        Me.lblDescrip.Text = "*Descripción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescrip, "")
        '
        'lblEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEstado, False)
        Me.lblEstado.AutoSize = True
        Me.lblEstado.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblEstado, "Default")
        Me.lblEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEstado.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblEstado.ForeColor = System.Drawing.Color.Navy
        Me.lblEstado.Location = New System.Drawing.Point(6, 54)
        Me.lblEstado.Name = "lblEstado"
        Me.COBISResourceProvider.SetResourceID(Me.lblEstado, "500073")
        Me.lblEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEstado.Size = New System.Drawing.Size(47, 13)
        Me.lblEstado.TabIndex = 2
        Me.lblEstado.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEstado, "")
        '
        'lblProductoBancario
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblProductoBancario, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblProductoBancario, False)
        Me.lblProductoBancario.AutoSize = True
        Me.lblProductoBancario.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblProductoBancario, "Default")
        Me.lblProductoBancario.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblProductoBancario.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblProductoBancario.ForeColor = System.Drawing.Color.Navy
        Me.lblProductoBancario.Location = New System.Drawing.Point(6, 31)
        Me.lblProductoBancario.Name = "lblProductoBancario"
        Me.COBISResourceProvider.SetResourceID(Me.lblProductoBancario, "500337")
        Me.lblProductoBancario.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblProductoBancario.Size = New System.Drawing.Size(102, 13)
        Me.lblProductoBancario.TabIndex = 0
        Me.lblProductoBancario.Text = "*Producto Bancario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblProductoBancario, "")
        '
        'lblTipoPersona
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTipoPersona, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTipoPersona, False)
        Me.lblTipoPersona.AutoSize = True
        Me.lblTipoPersona.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblTipoPersona, "Default")
        Me.lblTipoPersona.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTipoPersona.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTipoPersona.ForeColor = System.Drawing.Color.Navy
        Me.lblTipoPersona.Location = New System.Drawing.Point(6, 9)
        Me.lblTipoPersona.Name = "lblTipoPersona"
        Me.COBISResourceProvider.SetResourceID(Me.lblTipoPersona, "9031")
        Me.lblTipoPersona.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTipoPersona.Size = New System.Drawing.Size(77, 13)
        Me.lblTipoPersona.TabIndex = 10
        Me.lblTipoPersona.Text = "*Tipo Persona:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTipoPersona, "")
        '
        'lblTitularidad
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTitularidad, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTitularidad, False)
        Me.lblTitularidad.AutoSize = True
        Me.lblTitularidad.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblTitularidad, "Default")
        Me.lblTitularidad.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTitularidad.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTitularidad.ForeColor = System.Drawing.Color.Navy
        Me.lblTitularidad.Location = New System.Drawing.Point(6, 30)
        Me.lblTitularidad.Name = "lblTitularidad"
        Me.COBISResourceProvider.SetResourceID(Me.lblTitularidad, "500530")
        Me.lblTitularidad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTitularidad.Size = New System.Drawing.Size(63, 13)
        Me.lblTitularidad.TabIndex = 11
        Me.lblTitularidad.Text = "*Titularidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTitularidad, "")
        '
        'chkEspecial
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkEspecial, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkEspecial, False)
        Me.chkEspecial.BackColor = System.Drawing.Color.Transparent
        Me.chkEspecial.Checked = True
        Me.chkEspecial.CheckState = System.Windows.Forms.CheckState.Checked
        Me.COBISStyleProvider.SetControlStyle(Me.chkEspecial, "Default")
        Me.chkEspecial.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkEspecial.Enabled = False
        Me.chkEspecial.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.chkEspecial.ForeColor = System.Drawing.Color.Navy
        Me.chkEspecial.Location = New System.Drawing.Point(109, 52)
        Me.chkEspecial.Name = "chkEspecial"
        Me.COBISResourceProvider.SetResourceID(Me.chkEspecial, "500320")
        Me.chkEspecial.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkEspecial.Size = New System.Drawing.Size(16, 20)
        Me.chkEspecial.TabIndex = 5
        Me.chkEspecial.UseVisualStyleBackColor = False
        Me.chkEspecial.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkEspecial, "")
        '
        'lblEspecial
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEspecial, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEspecial, False)
        Me.lblEspecial.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblEspecial, "Default")
        Me.lblEspecial.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEspecial.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.lblEspecial.ForeColor = System.Drawing.Color.Navy
        Me.lblEspecial.Location = New System.Drawing.Point(126, 55)
        Me.lblEspecial.Name = "lblEspecial"
        Me.COBISResourceProvider.SetResourceID(Me.lblEspecial, "500534")
        Me.lblEspecial.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEspecial.Size = New System.Drawing.Size(92, 13)
        Me.lblEspecial.TabIndex = 17
        Me.lblEspecial.Text = "*Especial"
        Me.lblEspecial.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEspecial, "")
        '
        'PForma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PForma, False)
        Me.COBISViewResizer.SetAutoResize(Me.PForma, False)
        Me.PForma.Controls.Add(Me.UltraGroupBox1)
        Me.PForma.Controls.Add(Me.PForma2)
        Me.COBISStyleProvider.SetControlStyle(Me.PForma, "Default")
        Me.PForma.Location = New System.Drawing.Point(10, 36)
        Me.PForma.Name = "PForma"
        Me.PForma.Size = New System.Drawing.Size(625, 418)
        Me.PForma.TabIndex = 0
        Me.PForma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PForma, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.Controls.Add(Me.grdContratos)
        Me.UltraGroupBox1.Controls.Add(Me.lblEspecial)
        Me.UltraGroupBox1.Controls.Add(Me.lblTipoPersona)
        Me.UltraGroupBox1.Controls.Add(Me.lblDescripcion)
        Me.UltraGroupBox1.Controls.Add(Me.lblTitularidad)
        Me.UltraGroupBox1.Controls.Add(Me.txtPlantilla)
        Me.UltraGroupBox1.Controls.Add(Me.chkEspecial)
        Me.UltraGroupBox1.Controls.Add(Me.lblPlantilla)
        Me.UltraGroupBox1.Controls.Add(Me.lblDescrip)
        Me.UltraGroupBox1.Controls.Add(Me.txtTipoPersona)
        Me.UltraGroupBox1.Controls.Add(Me.txtTitularidad)
        Me.UltraGroupBox1.Controls.Add(Me.lblDescTitularidad)
        Me.UltraGroupBox1.Controls.Add(Me.lblDescTipoPersona)
        Me.UltraGroupBox1.Controls.Add(Me.lblContrato)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Location = New System.Drawing.Point(8, 105)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(602, 307)
        Me.UltraGroupBox1.TabIndex = 18
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'grdContratos
        '
        Me.grdContratos.AccessibleDescription = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdContratos, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdContratos, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdContratos, "Default")
        Me.grdContratos.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdContratos.Location = New System.Drawing.Point(6, 130)
        Me.grdContratos.Name = "grdContratos"
        Me.grdContratos.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.grdContratos.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.CobisSpread1_Sheet1})
        Me.grdContratos.Size = New System.Drawing.Size(587, 171)
        Me.grdContratos.StartingColNumber = 1
        Me.grdContratos.StartingRowNumber = 1
        Me.grdContratos.TabIndex = 8
        Me.grdContratos.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeVGABase
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdContratos, "")
        '
        'CobisSpread1_Sheet1
        '
        Me.CobisSpread1_Sheet1.Reset()
        Me.CobisSpread1_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.CobisSpread1_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.CobisSpread1_Sheet1.ColumnCount = 13
        Me.CobisSpread1_Sheet1.RowCount = 0
        Me.CobisSpread1_Sheet1.ActiveRowIndex = -1
        Me.CobisSpread1_Sheet1.ColumnHeader.AutoText = FarPoint.Win.Spread.HeaderAutoText.Blank
        Me.CobisSpread1_Sheet1.Columns.Get(0).CellType = CheckBoxCellType1
        Me.CobisSpread1_Sheet1.Columns.Get(0).Locked = False
        Me.CobisSpread1_Sheet1.Columns.Get(1).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(1).Width = 61.0!
        Me.CobisSpread1_Sheet1.Columns.Get(2).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(2).Width = 59.0!
        Me.CobisSpread1_Sheet1.Columns.Get(3).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(3).Visible = False
        Me.CobisSpread1_Sheet1.Columns.Get(4).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(4).Visible = False
        Me.CobisSpread1_Sheet1.Columns.Get(5).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(6).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(7).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(8).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(9).Locked = True
        Me.CobisSpread1_Sheet1.Columns.Get(10).Visible = False
        Me.CobisSpread1_Sheet1.Columns.Get(11).Visible = False
        Me.CobisSpread1_Sheet1.Columns.Get(12).Locked = True
        Me.CobisSpread1_Sheet1.RowHeader.Columns.Default.Resizable = False
        Me.CobisSpread1_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        Me.grdContratos.SetActiveViewport(0, -1, 0)
        '
        'lblDescripcion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescripcion, False)
        Me.lblDescripcion.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescripcion.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescripcion, "Default")
        Me.lblDescripcion.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescripcion.Location = New System.Drawing.Point(109, 98)
        Me.lblDescripcion.Name = "lblDescripcion"
        Me.lblDescripcion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescripcion.Size = New System.Drawing.Size(237, 20)
        Me.lblDescripcion.TabIndex = 9
        Me.lblDescripcion.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescripcion, "")
        '
        'txtPlantilla
        '
        Me.txtPlantilla.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtPlantilla, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtPlantilla, False)
        Me.txtPlantilla.BackColor = System.Drawing.SystemColors.Window
        Me.txtPlantilla.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtPlantilla.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper
        Me.COBISStyleProvider.SetControlStyle(Me.txtPlantilla, "Default")
        Me.txtPlantilla.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPlantilla.ForeColor = System.Drawing.Color.Black
        Me.txtPlantilla.Location = New System.Drawing.Point(109, 77)
        Me.txtPlantilla.MaxLength = 25
        Me.txtPlantilla.Name = "txtPlantilla"
        Me.txtPlantilla.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPlantilla.Size = New System.Drawing.Size(237, 20)
        Me.txtPlantilla.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtPlantilla, "")
        '
        'txtTipoPersona
        '
        Me.txtTipoPersona.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTipoPersona, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTipoPersona, False)
        Me.txtTipoPersona.BackColor = System.Drawing.SystemColors.Window
        Me.txtTipoPersona.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtTipoPersona.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper
        Me.COBISStyleProvider.SetControlStyle(Me.txtTipoPersona, "Default")
        Me.txtTipoPersona.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTipoPersona.ForeColor = System.Drawing.Color.Black
        Me.txtTipoPersona.Location = New System.Drawing.Point(110, 7)
        Me.txtTipoPersona.MaxLength = 1
        Me.txtTipoPersona.Name = "txtTipoPersona"
        Me.txtTipoPersona.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTipoPersona.Size = New System.Drawing.Size(31, 20)
        Me.txtTipoPersona.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTipoPersona, "")
        '
        'txtTitularidad
        '
        Me.txtTitularidad.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTitularidad, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTitularidad, False)
        Me.txtTitularidad.BackColor = System.Drawing.SystemColors.Window
        Me.txtTitularidad.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtTitularidad.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper
        Me.COBISStyleProvider.SetControlStyle(Me.txtTitularidad, "Default")
        Me.txtTitularidad.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTitularidad.ForeColor = System.Drawing.Color.Black
        Me.txtTitularidad.Location = New System.Drawing.Point(110, 29)
        Me.txtTitularidad.MaxLength = 1
        Me.txtTitularidad.Name = "txtTitularidad"
        Me.txtTitularidad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTitularidad.Size = New System.Drawing.Size(31, 20)
        Me.txtTitularidad.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTitularidad, "")
        '
        'lblDescTitularidad
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescTitularidad, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescTitularidad, False)
        Me.lblDescTitularidad.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescTitularidad.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescTitularidad, "Default")
        Me.lblDescTitularidad.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescTitularidad.Enabled = False
        Me.lblDescTitularidad.Location = New System.Drawing.Point(143, 29)
        Me.lblDescTitularidad.Name = "lblDescTitularidad"
        Me.lblDescTitularidad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescTitularidad.Size = New System.Drawing.Size(203, 20)
        Me.lblDescTitularidad.TabIndex = 15
        Me.lblDescTitularidad.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescTitularidad, "")
        '
        'lblDescTipoPersona
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescTipoPersona, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescTipoPersona, False)
        Me.lblDescTipoPersona.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescTipoPersona.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescTipoPersona, "Default")
        Me.lblDescTipoPersona.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescTipoPersona.Location = New System.Drawing.Point(143, 7)
        Me.lblDescTipoPersona.Name = "lblDescTipoPersona"
        Me.lblDescTipoPersona.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescTipoPersona.Size = New System.Drawing.Size(203, 20)
        Me.lblDescTipoPersona.TabIndex = 14
        Me.lblDescTipoPersona.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescTipoPersona, "")
        '
        'PForma2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PForma2, False)
        Me.COBISViewResizer.SetAutoResize(Me.PForma2, False)
        Me.PForma2.Controls.Add(Me.cmbTipo)
        Me.PForma2.Controls.Add(Me.lblProductoCobis)
        Me.PForma2.Controls.Add(Me.txtEstado)
        Me.PForma2.Controls.Add(Me.lblDescripcionEstado)
        Me.PForma2.Controls.Add(Me.lblEstado)
        Me.PForma2.Controls.Add(Me.cmbProductoBancario)
        Me.PForma2.Controls.Add(Me.lblProductoBancario)
        Me.COBISStyleProvider.SetControlStyle(Me.PForma2, "Default")
        Me.PForma2.Location = New System.Drawing.Point(8, 9)
        Me.PForma2.Name = "PForma2"
        Me.PForma2.Size = New System.Drawing.Size(602, 85)
        Me.PForma2.TabIndex = 2
        Me.PForma2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PForma2, "")
        '
        'cmbTipo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbTipo, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbTipo, False)
        Me.COBISStyleProvider.SetControlStyle(Me.cmbTipo, "Default")
        Me.cmbTipo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbTipo.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.cmbTipo.FormattingEnabled = True
        Me.cmbTipo.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.cmbTipo.Location = New System.Drawing.Point(109, 3)
        Me.cmbTipo.Name = "cmbTipo"
        Me.cmbTipo.Size = New System.Drawing.Size(237, 21)
        Me.cmbTipo.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipo, "")
        '
        'txtEstado
        '
        Me.txtEstado.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtEstado, False)
        Me.txtEstado.BackColor = System.Drawing.SystemColors.Window
        Me.txtEstado.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtEstado.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper
        Me.COBISStyleProvider.SetControlStyle(Me.txtEstado, "Default")
        Me.txtEstado.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtEstado.ForeColor = System.Drawing.Color.Black
        Me.txtEstado.Location = New System.Drawing.Point(110, 52)
        Me.txtEstado.MaxLength = 1
        Me.txtEstado.Name = "txtEstado"
        Me.txtEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtEstado.Size = New System.Drawing.Size(31, 20)
        Me.txtEstado.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtEstado, "")
        '
        'lblDescripcionEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescripcionEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescripcionEstado, False)
        Me.lblDescripcionEstado.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescripcionEstado.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescripcionEstado, "Default")
        Me.lblDescripcionEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescripcionEstado.Location = New System.Drawing.Point(143, 52)
        Me.lblDescripcionEstado.Name = "lblDescripcionEstado"
        Me.lblDescripcionEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescripcionEstado.Size = New System.Drawing.Size(203, 20)
        Me.lblDescripcionEstado.TabIndex = 4
        Me.lblDescripcionEstado.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescripcionEstado, "")
        '
        'cmbProductoBancario
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbProductoBancario, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbProductoBancario, False)
        Me.COBISStyleProvider.SetControlStyle(Me.cmbProductoBancario, "Default")
        Me.cmbProductoBancario.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbProductoBancario.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.cmbProductoBancario.FormattingEnabled = True
        Me.cmbProductoBancario.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.cmbProductoBancario.Location = New System.Drawing.Point(109, 28)
        Me.cmbProductoBancario.Name = "cmbProductoBancario"
        Me.cmbProductoBancario.Size = New System.Drawing.Size(237, 21)
        Me.cmbProductoBancario.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbProductoBancario, "")
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'FTra2946Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.Controls.Add(Me.PForma)
        Me.Controls.Add(Me.TSButton)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FTra2946Class"
        Me.Size = New System.Drawing.Size(639, 473)
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSButton.ResumeLayout(False)
        Me.TSButton.PerformLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PForma.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me.grdContratos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.CobisSpread1_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PForma2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PForma2.ResumeLayout(False)
        Me.PForma2.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TSButton As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Public WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Friend WithEvents PForma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PForma2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents lblProductoCobis As System.Windows.Forms.Label
    Friend WithEvents cmbTipo As System.Windows.Forms.ComboBox
    Friend WithEvents cmbProductoBancario As System.Windows.Forms.ComboBox
    Private WithEvents lblProductoBancario As System.Windows.Forms.Label
    Private WithEvents lblEstado As System.Windows.Forms.Label
    Private WithEvents lblDescripcionEstado As System.Windows.Forms.Label
    Private WithEvents txtEstado As System.Windows.Forms.TextBox
    Private WithEvents lblDescripcion As System.Windows.Forms.Label
    Private WithEvents txtPlantilla As System.Windows.Forms.TextBox
    Private WithEvents lblContrato As System.Windows.Forms.Label
    Private WithEvents lblPlantilla As System.Windows.Forms.Label
    Private WithEvents lblDescrip As System.Windows.Forms.Label
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Private WithEvents lblDescTitularidad As System.Windows.Forms.Label
    Private WithEvents lblDescTipoPersona As System.Windows.Forms.Label
    Private WithEvents txtTitularidad As System.Windows.Forms.TextBox
    Private WithEvents txtTipoPersona As System.Windows.Forms.TextBox
    Private WithEvents lblTitularidad As System.Windows.Forms.Label
    Private WithEvents lblTipoPersona As System.Windows.Forms.Label
    Public WithEvents chkEspecial As System.Windows.Forms.CheckBox
    Private WithEvents lblEspecial As System.Windows.Forms.Label
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents grdContratos As COBISCorp.Framework.UI.Components.COBISSpread
    Friend WithEvents CobisSpread1_Sheet1 As FarPoint.Win.Spread.SheetView

End Class
