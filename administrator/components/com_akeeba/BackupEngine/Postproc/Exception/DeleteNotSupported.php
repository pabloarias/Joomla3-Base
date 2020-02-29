<?php
/**
 * Akeeba Engine
 *
 * @package   akeebaengine
 * @copyright Copyright (c)2006-2020 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Engine\Postproc\Exception;

/**
 * Indicates that the post-processing engine does not support deleting remotely stored files.
 */
class DeleteNotSupported extends EngineException
{
	protected $messagePrototype = 'The %s post-processing engine does not support deletion of backup archives.';
}