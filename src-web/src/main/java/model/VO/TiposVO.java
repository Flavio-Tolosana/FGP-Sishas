package model.VO;

/**
 * Clase que representa un tipo de producto.
 * Almacena la información relacionada con un tipo específico de producto.
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class TiposVO {

    private int idTipo; // Identificador del tipo de producto
    private String nombreTipo; // Nombre del tipo de producto
    
    /**
     * Constructor de la clase TiposVO.
     * 
     * @param idTipo     Identificador del tipo de producto
     * @param nombreTipo Nombre del tipo de producto
     */
    public TiposVO(int idTipo, String nombreTipo) {
        this.idTipo = idTipo;
        this.nombreTipo = nombreTipo;
    }

    /**
     * Obtiene el identificador del tipo de producto.
     * 
     * @return El identificador del tipo de producto
     */
    public int getIdTipo() {
        return idTipo;
    }

    /**
     * Establece el identificador del tipo de producto.
     * 
     * @param idTipo El identificador del tipo de producto a establecer
     */
    public void setIdTipo(int idTipo) {
        this.idTipo = idTipo;
    }

    /**
     * Obtiene el nombre del tipo de producto.
     * 
     * @return El nombre del tipo de producto
     */
    public String getNombreTipo() {
        return nombreTipo;
    }

    /**
     * Establece el nombre del tipo de producto.
     * 
     * @param nombreTipo El nombre del tipo de producto a establecer
     */
    public void setNombreTipo(String nombreTipo) {
        this.nombreTipo = nombreTipo;
    }
}
