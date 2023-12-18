package model.VO;

/**
 * Clase que representa la información de un producto.
 * Almacena los detalles relacionados con un producto en particular.
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosona Hernando
 * @author Pablo Pina Gracia
 */
public class ProductoVO {

    private int idProducto; // Identificador único del producto
    private String nombre; // Nombre del producto
    private String estadoProducto; // Estado actual del producto
    private String marca; // Marca del producto
    private String color; // Color del producto
    private Float precio; // Precio del producto
    private int tipoProducto; // Tipo de producto
    private String estadoVenta; // Estado de la venta del producto
    private Float precioVenta; // Precio de venta del producto
    private int unidades; // Cantidad de unidades disponibles
    private String urlFoto; // URL de la foto del producto
    private String usuarioVendedorProducto; // Usuario vendedor del producto
    private String nombreTipoProducto; // Nombre del tipo de producto
    
    /**
     * Constructor de la clase ProductoVO.
     * 
     * @param idProducto                Identificador único del producto
     * @param nombre                    Nombre del producto
     * @param estadoProducto            Estado actual del producto
     * @param marca                     Marca del producto
     * @param color                     Color del producto
     * @param precio                    Precio del producto
     * @param tipoProducto              Tipo de producto
     * @param estadoVenta               Estado de la venta del producto
     * @param precioVenta               Precio de venta del producto
     * @param unidades                  Cantidad de unidades disponibles
     * @param urlFoto                   URL de la foto del producto
     * @param usuarioVendedorProducto   Usuario vendedor del producto
     * @param nombreTipoProducto        Nombre del tipo de producto
     */
    public ProductoVO(int idProducto, String nombre, String estadoProducto, String marca, String color,
            Float precio, int tipoProducto, String estadoVenta, Float precioVenta, int unidades, 
            String urlFoto, String usuarioVendedorProducto, String nombreTipoProducto) {

        this.idProducto = idProducto;
        this.nombre = nombre;
        this.estadoProducto = estadoProducto;
        this.marca = marca;
        this.color = color;
        this.precio = precio;
        this.tipoProducto = tipoProducto;
        this.estadoVenta = estadoVenta;
        this.precioVenta = precioVenta;
        this.unidades = unidades;
        this.urlFoto = urlFoto;
        this.usuarioVendedorProducto = usuarioVendedorProducto;
        this.nombreTipoProducto = nombreTipoProducto;
    }

    /**
     * Constructor vacío de la clase ProductoVO.
     */
    public ProductoVO() {
        // TODO Auto-generated constructor stub
    }

    /**
     * Obtiene el identificador único del producto.
     * 
     * @return El identificador del producto
     */
    public int getIdProducto() {
        return idProducto;
    }

    /**
     * Establece el identificador único del producto.
     * 
     * @param idProducto El identificador del producto a establecer
     */
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    /**
     * Obtiene el nombre del producto.
     * 
     * @return El nombre del producto
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Establece el nombre del producto.
     * 
     * @param nombre El nombre del producto a establecer
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Obtiene el estado actual del producto.
     * 
     * @return El estado actual del producto
     */
    public String getEstadoProducto() {
        return estadoProducto;
    }

    /**
     * Establece el estado actual del producto.
     * 
     * @param estadoProducto El estado actual del producto a establecer
     */
    public void setEstadoProducto(String estadoProducto) {
        this.estadoProducto = estadoProducto;
    }

    /**
     * Obtiene la marca del producto.
     * 
     * @return La marca del producto
     */
    public String getMarca() {
        return marca;
    }

    /**
     * Establece la marca del producto.
     * 
     * @param marca La marca del producto a establecer
     */
    public void setMarca(String marca) {
        this.marca = marca;
    }

    /**
     * Obtiene el color del producto.
     * 
     * @return El color del producto
     */
    public String getColor() {
        return color;
    }

    /**
     * Establece el color del producto.
     * 
     * @param color El color del producto a establecer
     */
    public void setColor(String color) {
        this.color = color;
    }

    /**
     * Obtiene el precio del producto.
     * 
     * @return El precio del producto
     */
    public Float getPrecio() {
        return precio;
    }

    /**
     * Establece el precio del producto.
     * 
     * @param precio El precio del producto a establecer
     */
    public void setPrecio(Float precio) {
        this.precio = precio;
    }

    /**
     * Obtiene el tipo de producto.
     * 
     * @return El tipo de producto
     */
    public int getTipoProducto() {
        return tipoProducto;
    }

    /**
     * Establece el tipo de producto.
     * 
     * @param tipoProducto El tipo de producto a establecer
     */
    public void setTipoProducto(int tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    /**
     * Obtiene el estado de la venta del producto.
     * 
     * @return El estado de la venta del producto
     */
    public String getEstadoVenta() {
        return estadoVenta;
    }

    /**
     * Establece el estado de la venta del producto.
     * 
     * @param estadoVenta El estado de la venta del producto a establecer
     */
    public void setEstadoVenta(String estadoVenta) {
        this.estadoVenta = estadoVenta;
    }

    /**
     * Obtiene el precio de venta del producto.
     * 
     * @return El precio de venta del producto
     */
    public Float getPrecioVenta() {
        return precioVenta;
    }

    /**
     * Establece el precio de venta del producto.
     * 
     * @param precioVenta El precio de venta del producto a establecer
     */
    public void setPrecioVenta(Float precioVenta) {
        this.precioVenta = precioVenta;
    }

    /**
     * Obtiene la cantidad de unidades disponibles del producto.
     * 
     * @return La cantidad de unidades disponibles
     */
    public int getUnidades() {
        return unidades;
    }

    /**
     * Establece la cantidad de unidades disponibles del producto.
     * 
     * @param unidades La cantidad de unidades disponibles a establecer
     */
    public void setUnidades(int unidades) {
        this.unidades = unidades;
    }

    /**
     * Obtiene la URL de la foto del producto.
     * 
     * @return La URL de la foto del producto
     */
    public String getUrlFoto() {
        return urlFoto;
    }

    /**
     * Establece la URL de la foto del producto.
     * 
     * @param urlFoto La URL de la foto del producto a establecer
     */
    public void setUrlFoto(String urlFoto) {
        this.urlFoto = urlFoto;
    }

    /**
     * Obtiene el usuario vendedor del producto.
     * 
     * @return El usuario vendedor del producto
     */
    public String getUsuarioVendedorProducto() {
        return usuarioVendedorProducto;
    }

    /**
     * Establece el usuario vendedor del producto.
     * 
     * @param usuarioVendedorProducto El usuario vendedor del producto a establecer
     */
    public void setUsuarioVendedorProducto(String usuarioVendedorProducto) {
        this.usuarioVendedorProducto = usuarioVendedorProducto;
    }

    /**
     * Obtiene el nombre del tipo de producto.
     * 
     * @return El nombre del tipo de producto
     */
    public String getNombreTipoProducto() {
        return nombreTipoProducto;
    }

    /**
     * Establece el nombre del tipo de producto.
     * 
     * @param nombreTipoProducto El nombre del tipo de producto a establecer
     */
    public void setNombreTipoProducto(String nombreTipoProducto) {
        this.nombreTipoProducto = nombreTipoProducto;
    }
}
