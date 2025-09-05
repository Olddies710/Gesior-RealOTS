<?php
if (!defined('INITIALIZED'))
    exit;

class Account extends ObjectData
{
    const LOADTYPE_ID = 'id';
    const LOADTYPE_NAME = 'login';
    const LOADTYPE_MAIL = 'email';
    public static $table = 'users';
    public $data = array('banished' => 0, 'premium' => 1);
    public static $fields = array('id', 'login', 'passwd', 'email', 'session_ip', 'last_ip', 'last_ts', 'userlevel', 'premium',
        'banished', 'banished_until', 'premium_days', 'trial_premium', 'trial_premium_days', 'bandelete', 'creation_ip',
        'lastrecover', 'posts', 'key', 'create_ip', 'create_date', 'premium_points', 'page_access', 'roses',
        'location', 'rlname', 'email_new', 'email_new_time', 'email_code', 'next_email', 'last_post', 'flag');
    public $players;
    public $playerRanks;
    public $guildAccess;
    public $bans;

public function __construct($search_text = null, $search_by = self::LOADTYPE_ID)
{
    // Solo inicializar si se proporciona un valor de búsqueda
    if ($search_text != null)
        $this->load($search_text, $search_by);
}

public function load($search_text, $search_by = self::LOADTYPE_ID)
{
    if (in_array($search_by, self::$fields))
        $search_string = $this->getDatabaseHandler()->fieldName($search_by) . ' = ' . $this->getDatabaseHandler()->quote($search_text);
    else
        new Error_Critic('', 'Wrong Account search_by type.');
    
    // Inicializar con valores por defecto primero
    foreach (self::$fields as $fieldName) {
        $this->data[$fieldName] = null;
    }
    
    $fieldsArray = array();
    foreach (self::$fields as $fieldName)
        $fieldsArray[$fieldName] = $this->getDatabaseHandler()->fieldName($fieldName);
    
    $result = $this->getDatabaseHandler()->query('SELECT ' . implode(', ', $fieldsArray) . ' FROM ' . $this->getDatabaseHandler()->tableName(self::$table) . ' WHERE ' . $search_string)->fetch();
    
    // Luego asignar los valores del resultado si existe
    if ($result) {
        foreach ($result as $key => $value) {
            $this->data[$key] = $value;
        }
    }
}

    public function loadById($id)
    {
        $this->load($id, self::LOADTYPE_ID);
    }

    public function loadByName($name)
    {
        $this->load($name, self::LOADTYPE_NAME);
    }

    public function loadByEmail($mail)
    {
        $this->load($mail, self::LOADTYPE_MAIL);
    }

    public function save($forceInsert = false)
    {
        if (!isset($this->data['id']) || $forceInsert) {
            $keys = array();
            $values = array();
            foreach (self::$fields as $key)
                if ($key != 'id') {
                    $keys[] = $this->getDatabaseHandler()->fieldName($key);
                    $values[] = $this->getDatabaseHandler()->quote($this->data[$key]);
                }
            $this->getDatabaseHandler()->query('INSERT INTO ' . $this->getDatabaseHandler()->tableName(self::$table) . ' (' . implode(', ', $keys) . ') VALUES (' . implode(', ', $values) . ')');
            $this->setID($this->getDatabaseHandler()->lastInsertId());
        } else {
            $updates = array();
            foreach (self::$fields as $key)
                if ($key != 'id')
                    $updates[] = $this->getDatabaseHandler()->fieldName($key) . ' = ' . $this->getDatabaseHandler()->quote($this->data[$key]);
            $this->getDatabaseHandler()->query('UPDATE ' . $this->getDatabaseHandler()->tableName(self::$table) . ' SET ' . implode(', ', $updates) . ' WHERE ' . $this->getDatabaseHandler()->fieldName('id') . ' = ' . $this->getDatabaseHandler()->quote($this->data['id']));
        }
    }

    public function getPlayers($forceReload = false)
    {
        if (!isset($this->players) || $forceReload) {
            $this->players = new DatabaseList('Player');
            $this->players->setFilter(new SQL_Filter(new SQL_Field(Player::LOADTYPE_ACCOUNT_ID), SQL_Filter::EQUAL, $this->getID()));
            $this->players->addOrder(new SQL_Order(new SQL_Field(Player::LOADTYPE_NAME)));
        }
        return $this->players;
    }

    public function delete()
    {
        $this->getDatabaseHandler()->query('DELETE FROM ' . $this->getDatabaseHandler()->tableName(self::$table) . ' WHERE ' . $this->getDatabaseHandler()->fieldName('id') . ' = ' . $this->getDatabaseHandler()->quote($this->data['id']));

        unset($this->data['id']);
    }

    public function setID($value)
    {
        $this->data['id'] = $value;
    }

    public function getID()
    {
        return $this->data['id'];
    }

    public function setName($value)
    {
        $this->setLogin($value);
    }

    public function getName()
    {
        return $this->getLogin();
    }

    public function setLogin($value)
    {
        $this->data['login'] = $value;
    }

    public function getLogin()
    {
        return $this->data['login'];
    }

    public function setPassword($value)
    {
        $this->data['passwd'] = Website::encryptPassword($value, $this);
    }

    public function getPassword()
    {
        return $this->data['passwd'];
    }

    public function setPremDays($value)
    {
        $this->data['premium_days'] = $value;
    }

    public function getPremDays()
    {
        return $this->data['premium_days'];
    }

    public function setMail($value)
    {
        $this->data['email'] = $value;
    }

    public function getMail()
    {
        return $this->data['email'];
    }

    public function setKey($value)
    {
        $this->data['key'] = $value;
    }

    public function getKey()
    {
        return $this->data['key'];
    }

    /*
     * Custom AAC fields
     * create_ip , INT, default 0
     * premium_points , INT, default 0
     * page_access, INT, default 0
     * location, VARCHAR(255), default ''
     * rlname, VARCHAR(255), default ''
    */
    public function setCreateIP($value)
    {
        $this->data['create_ip'] = $value;
    }

    public function getCreateIP()
    {
        return $this->data['create_ip'];
    }

    public function setCreateDate($value)
    {
    $this->data['create_date'] = $value; // Cambiar 'creation' por 'create_date'
    }

    public function getCreateDate()
    {
    return $this->data['create_date']; // Cambiar 'creation' por 'create_date'
    }

    public function setPremiumPoints($value)
    {
        $this->data['premium_points'] = $value;
    }

    public function getPremiumPoints()
    {
        return $this->data['premium_points'];
    }

    public function setPageAccess($value)
    {
        $this->data['page_access'] = $value;
    }

    public function getPageAccess()
    {
        return $this->data['page_access'];
    }

    public function setLocation($value)
    {
        $this->data['location'] = $value;
    }

    public function getLocation()
    {
        return $this->data['location'];
    }

    public function setRLName($value)
    {
        $this->data['rlname'] = $value;
    }

    public function getRLName()
    {
        return $this->data['rlname'];
    }

    public function setFlag($value)
    {
        $this->data['flag'] = $value;
    }

    public function getFlag()
    {
        return $this->data['flag'];
    }

    /*
     * for compability with old scripts
    */
    public function getEMail()
    {
        return $this->getMail();
    }

    public function setEMail($value)
    {
        $this->setMail($value);
    }

    public function getPlayersList()
    {
        return $this->getPlayers();
    }

    public function isValidPassword($password)
    {
        return ($this->data['passwd'] == Website::encryptPassword($password, $this));
    }

    public function find($name)
    {
        $this->loadByName($name);
    }

    public function findByEmail($email)
    {
        $this->loadByEmail($email);
    }

    public function isPremium()
    {
        return ($this->data['premium'] == 1);
    }
}