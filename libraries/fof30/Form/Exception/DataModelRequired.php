<?php
/**
 * @package     FOF
 * @copyright   2010-2017 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license     GNU GPL version 2 or later
 */

namespace FOF30\Form\Exception;

use Exception;

defined('_JEXEC') or die;

class DataModelRequired extends \RuntimeException
{
	public function __construct($className, $code = 0, Exception $previous = null)
	{
		$message = \JText::sprintf('LIB_FOF_FORM_ERR_DATAMODEL_REQUIRED', $className);

		parent::__construct($message, $code, $previous);
	}
}