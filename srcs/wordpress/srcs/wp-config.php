<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('WP_DB_NAME') );

/** MySQL database username */
define( 'DB_USER', getenv('WP_DB_USER') );

/** MySQL database password */
define( 'DB_PASSWORD', getenv('WP_DB_PASSWD') );

/** MySQL hostname */
define( 'DB_HOST', getenv('WP_DB_HOST') );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'ndDp;iWAM]ytVS6#zRe/HfpGX(VU^-dlZL,~O:YOWLocP85jvBQEUhwL#==W?_1#');
define('SECURE_AUTH_KEY',  '.BX-xT2Q=oie-wK1^#RfZD#-i,$3IoDA<C#Qe%>2Rr&,;$[7(qtZ1!Y|7hqXI|C8');
define('LOGGED_IN_KEY',    'ygP<1v#5(fF)mBI+GhJ-]xQyZh->!2I) }u_ajB7BqZj2{a^J*m#Ll|^F/fW+8cl');
define('NONCE_KEY',        ';m^_<lSc-}/lvG:O*/.6y,fzB(JhnXiZdW5UfV+Sad:%f-kc<:g`Y?ce1lEZ;!+=');
define('AUTH_SALT',        ';>&.Kk=6&/m7{tW9`h@>CFEHq~tCeBm!4ot@8,sU4T!nl?|bpt*,3)bLF+3+d4A-');
define('SECURE_AUTH_SALT', '+/oq(+%Z*3KPg]*8 !!3kA.NX_Yj@ApM(c<c5Bv0d.Ds-N{d}$$4&R?_}`Ri$-Tp');
define('LOGGED_IN_SALT',   'M=z)n+7LscAB+Aw#%PN@4Yzr(siJ|T)$OTFNL^U>MHu-3yt<,62`=NOj<^imR@Eq');
define('NONCE_SALT',       'wsG#VIgjd)4jZFg>hS>g_6% ?B/z[>l-o]Xl4}1fD5DtCId!vpBS*Q} *k{7#Yvy');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_db_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';