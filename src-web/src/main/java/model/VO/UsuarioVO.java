package model.VO;

/**
 * Esta clase representa un objeto de usuario con su información básica.
 * Contiene métodos para acceder y modificar esta información.
 * 
 * @author Gonzalo Valero Domingo
 */
public class UsuarioVO {

    private String correoElectronico; // Correo electrónico del usuario
    private String nombre; // Nombre del usuario
    private String apellidos; // Apellidos del usuario
    private String contrasegna; // Contraseña del usuario

    private String calle; // Calle donde vive el usuario
    private String pisoPuerta; // Número de piso o puerta del usuario
    private String codigoPostal; // Código postal de la dirección del usuario
    private String numeroTelefono; // Número de teléfono del usuario

    private Boolean esAdmin; // Indica si el usuario tiene privilegios de administrador

    /**
     * Constructor para inicializar un UsuarioVO con todos los detalles.
     * 
     * @param correoElectronico El correo electrónico del usuario.
     * @param nombre El nombre del usuario.
     * @param apellidos Los apellidos del usuario.
     * @param contrasegna La contraseña del usuario.
     * @param calle La calle donde vive el usuario.
     * @param pisoPuerta El número de piso o puerta del usuario.
     * @param codigoPostal El código postal de la dirección del usuario.
     * @param numeroTelefono El número de teléfono del usuario.
     * @param esAdmin Indica si el usuario tiene privilegios de administrador.
     */
    public UsuarioVO(String correoElectronico, String nombre, String apellidos, String contrasegna, String calle,
                     String pisoPuerta, String codigoPostal, String numeroTelefono, Boolean esAdmin) {
        this.correoElectronico = correoElectronico;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.contrasegna = contrasegna;
        this.calle = calle;
        this.pisoPuerta = pisoPuerta;
        this.codigoPostal = codigoPostal;
        this.numeroTelefono = numeroTelefono;
        this.esAdmin = esAdmin;
    }

    /**
     * Constructor para inicializar un UsuarioVO sin detalles de dirección.
     * 
     * @param correoElectronico El correo electrónico del usuario.
     * @param nombre El nombre del usuario.
     * @param apellidos Los apellidos del usuario.
     * @param contrasegna La contraseña del usuario.
     * @param esAdmin Indica si el usuario tiene privilegios de administrador.
     */
    public UsuarioVO(String correoElectronico, String nombre, String apellidos, String contrasegna, Boolean esAdmin) {
        this.correoElectronico = correoElectronico;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.contrasegna = contrasegna;
        this.esAdmin = esAdmin;
    }

    /**
     * Constructor vacío por defecto.
     */
    public UsuarioVO() {
        // Constructor vacío por defecto
    }

    /**
     * Obtiene el correo electrónico del usuario.
     * 
     * @return El correo electrónico del usuario.
     */
    public String getCorreoElectronico() {
        return correoElectronico;
    }

    /**
     * Establece el correo electrónico del usuario.
     * 
     * @param correoElectronico El nuevo correo electrónico del usuario.
     */
    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    /**
     * Obtiene el nombre del usuario.
     * 
     * @return El nombre del usuario.
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Establece el nombre del usuario.
     * 
     * @param nombre El nuevo nombre del usuario.
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Obtiene los apellidos del usuario.
     * 
     * @return Los apellidos del usuario.
     */
    public String getApellidos() {
        return apellidos;
    }

    /**
     * Establece los apellidos del usuario.
     * 
     * @param apellidos Los nuevos apellidos del usuario.
     */
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    /**
     * Obtiene la contraseña del usuario.
     * 
     * @return La contraseña del usuario.
     */
    public String getContrasegna() {
        return contrasegna;
    }

    /**
     * Establece la contraseña del usuario.
     * 
     * @param contrasegna La nueva contraseña del usuario.
     */
    public void setContrasegna(String contrasegna) {
        this.contrasegna = contrasegna;
    }

    /**
     * Obtiene la calle donde vive el usuario.
     * 
     * @return La calle donde vive el usuario.
     */
    public String getCalle() {
        return calle;
    }

    /**
     * Establece la calle donde vive el usuario.
     * 
     * @param calle La nueva calle donde vive el usuario.
     */
    public void setCalle(String calle) {
        this.calle = calle;
    }

    /**
     * Obtiene el número de piso o puerta del usuario.
     * 
     * @return El número de piso o puerta del usuario.
     */
    public String getPisoPuerta() {
        return pisoPuerta;
    }

    /**
     * Establece el número de piso o puerta del usuario.
     * 
     * @param pisoPuerta El nuevo número de piso o puerta del usuario.
     */
    public void setPisoPuerta(String pisoPuerta) {
        this.pisoPuerta = pisoPuerta;
    }

    /**
     * Obtiene el código postal de la dirección del usuario.
     * 
     * @return El código postal de la dirección del usuario.
     */
    public String getCodigoPostal() {
        return codigoPostal;
    }

    /**
     * Establece el código postal de la dirección del usuario.
     * 
     * @param codigoPostal El nuevo código postal de la dirección del usuario.
     */
    public void setCodigoPostal(String codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    /**
     * Obtiene el número de teléfono del usuario.
     * 
     * @return El número de teléfono del usuario.
     */
    public String getNumeroTelefono() {
        return numeroTelefono;
    }

    /**
     * Establece el número de teléfono del usuario.
     * 
     * @param numeroTelefono El nuevo número de teléfono del usuario.
     */
    public void setNumeroTelefono(String numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }

    /**
     * Indica si el usuario tiene privilegios de administrador.
     * 
     * @return true si el usuario es administrador, false si no lo es.
     */
    public Boolean getEsAdmin() {
        return esAdmin;
    }

    /**
     * Establece los privilegios de administrador del usuario.
     * 
     * @param esAdmin true si se desea dar privilegios de administrador, false si no.
     */
    public void setEsAdmin(Boolean esAdmin) {
        this.esAdmin = esAdmin;
    }
}
