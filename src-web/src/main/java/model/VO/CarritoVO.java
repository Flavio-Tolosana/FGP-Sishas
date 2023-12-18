package model.VO;

/**
 * Clase que representa un elemento de un carrito de compras.
 * Almacena la información relacionada con un producto añadido al carrito.
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class CarritoVO {

    private String correoElectronico; // Correo electrónico asociado al carrito
    private int idProducto; // Identificador del producto añadido al carrito
    private int cantidad; // Cantidad del producto en el carrito

    /**
     * Constructor de la clase CarritoVO.
     * 
     * @param correoElectronico Correo electrónico asociado al carrito
     * @param idProducto        Identificador del producto añadido al carrito
     * @param cantidad          Cantidad del producto en el carrito
     */
    public CarritoVO(String correoElectronico, int idProducto, int cantidad) {
        this.correoElectronico = correoElectronico;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    /**
     * Obtiene el correo electrónico asociado al carrito.
     * 
     * @return El correo electrónico asociado al carrito
     */
    public String getCorreoElectronico() {
        return correoElectronico;
    }

    /**
     * Establece el correo electrónico asociado al carrito.
     * 
     * @param correoElectronico El correo electrónico a establecer
     */
    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    /**
     * Obtiene el identificador del producto en el carrito.
     * 
     * @return El identificador del producto en el carrito
     */
    public int getIdProducto() {
        return idProducto;
    }

    /**
     * Establece el identificador del producto en el carrito.
     * 
     * @param idProducto El identificador del producto a establecer
     */
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    /**
     * Obtiene la cantidad del producto en el carrito.
     * 
     * @return La cantidad del producto en el carrito
     */
    public int getCantidad() {
        return cantidad;
    }

    /**
     * Establece la cantidad del producto en el carrito.
     * 
     * @param cantidad La cantidad del producto a establecer
     */
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
