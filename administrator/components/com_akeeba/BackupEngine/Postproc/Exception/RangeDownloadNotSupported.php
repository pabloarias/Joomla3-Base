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
 * Indicates that the post-processing engine does not support range downloads.
 */
class RangeDownloadNotSupported extends EngineException
{
	protected $messagePrototype = 'The %s post-processing engine does not support range downloads of backup archives to the server.';
}