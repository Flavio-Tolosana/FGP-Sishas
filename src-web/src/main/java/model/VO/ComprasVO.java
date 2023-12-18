package model.VO;

/**
 * Clase que representa la información de una compra realizada.
 * Almacena los detalles de un producto comprado.
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class ComprasVO {

    private String correoElectronico; // Correo electrónico asociado a la compra
    private int idProducto; // Identificador del producto comprado
    private int cantidad; // Cantidad del producto comprado
    private String tiempoCompra; // Tiempo en que se realizó la compra
    private float precio; // Precio del producto

    /**
     * Constructor de la clase ComprasVO.
     * 
     * @param correoElectronico Correo electrónico asociado a la compra
     * @param idProducto        Identificador del producto comprado
     * @param cantidad          Cantidad del producto comprado
     * @param tiempoCompra      Tiempo en que se realizó la compra
     * @param precio            Precio del producto
     */
    public ComprasVO(String correoElectronico, int idProducto, int cantidad, String tiempoCompra, float precio) {
        this.correoElectronico = correoElectronico;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
        this.tiempoCompra = tiempoCompra;
        this.precio = precio;
    }

    // Métodos para obtener y establecer los atributos

    /**
     * Obtiene el correo electrónico asociado a la compra.
     * 
     * @return El correo electrónico asociado a la compra
     */
    public String getCorreoElectronico() {
        return correoElectronico;
    }

    /**
     * Establece el correo electrónico asociado a la compra.
     * 
     * @param correoElectronico El correo electrónico a establecer
     */
    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    /**
     * Obtiene el identificador del producto comprado.
     * 
     * @return El identificador del producto comprado
     */
    public int getIdProducto() {
        return idProducto;
    }

    /**
     * Establece el identificador del producto comprado.
     * 
     * @param idProducto El identificador del producto a establecer
     */
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    /**
     * Obtiene la cantidad del producto comprado.
     * 
     * @return La cantidad del producto comprado
     */
    public int getCantidad() {
        return cantidad;
    }

    /**
     * Establece la cantidad del producto comprado.
     * 
     * @param cantidad La cantidad del producto a establecer
     */
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    /**
     * Obtiene el tiempo en que se realizó la compra.
     * 
     * @return El tiempo de la compra
     */
    public String getTiempoCompra() {
        return tiempoCompra;
    }

    /**
     * Establece el tiempo en que se realizó la compra.
     * 
     * @param tiempoCompra El tiempo de la compra a establecer
     */
    public void setTiempoCompra(String tiempoCompra) {
        this.tiempoCompra = tiempoCompra;
    }

    /**
     * Obtiene el precio del producto comprado.
     * 
     * @return El precio del producto comprado
     */
    public float getPrecio() {
        return precio;
    }

    /**
     * Establece el precio del producto comprado.
     * 
     * @param precio El precio del producto a establecer
     */
    public void setPrecio(float precio) {
        this.precio = precio;
    }
}